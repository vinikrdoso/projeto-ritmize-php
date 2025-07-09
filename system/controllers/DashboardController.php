<?php

require_once __DIR__ . '/../core/Database.php';
require_once 'vendor/autoload.php';

use Ritmize\core\Database;
use Twig\Environment;
use Twig\Loader\FilesystemLoader;

class DashboardController {
    
    private $db;
    private $twig;
    
    public function __construct() {
        $this->db = Database::getInstance();
        
        // Configurar Twig
        $loader = new FilesystemLoader('templates');
        $this->twig = new Environment($loader, [
            'debug' => true
        ]);
        $this->twig->addExtension(new \Twig\Extension\DebugExtension());
    }
    
    public function index() {
        // Verificar se usuário está logado (simulação para teste)
        $alunoId = $_SESSION['aluno_id'] ?? 1; // João por padrão para teste
        
        try {
            // Buscar dados do aluno
            $aluno = $this->db->fetch("SELECT * FROM alunos WHERE id = ?", [$alunoId]);
            
            if (!$aluno) {
                throw new Exception("Aluno não encontrado");
            }
            
            // Buscar mensalidade atual (mês atual)
            $mesAtual = date('Y-m-01');
            $mensalidadeAtual = $this->db->fetch("
                SELECT * FROM mensalidades 
                WHERE aluno_id = ? AND mes_referencia = ?
                ORDER BY created_at DESC
                LIMIT 1
            ", [$alunoId, $mesAtual]);
            
            // Buscar próxima aula
            $proximaAula = $this->calcularProximaAula($alunoId);
            
            // Buscar estatísticas de presença
            $estatisticasPresenca = $this->calcularEstatisticasPresenca($alunoId);
            
            // Buscar notificações ativas
            $dataAtual = date('Y-m-d');
            $notificacoes = $this->db->fetchAll("
                SELECT * FROM notificacoes 
                WHERE (aluno_id IS NULL OR aluno_id = ?) 
                AND data_inicio <= ? 
                AND (data_fim IS NULL OR data_fim >= ?)
                ORDER BY created_at DESC
                LIMIT 5
            ", [$alunoId, $dataAtual, $dataAtual]);
            
            // Renderizar template
            echo $this->twig->render('dashboard.twig', [
                'page' => 'dashboard',
                'aluno' => $aluno,
                'mensalidade_atual' => $mensalidadeAtual,
                'proxima_aula' => $proximaAula,
                'estatisticas_presenca' => $estatisticasPresenca,
                'notificacoes' => $notificacoes
            ]);
            
        } catch (Exception $e) {
            echo "<h2>Erro no Dashboard</h2>";
            echo "<p>" . $e->getMessage() . "</p>";
        }
    }
    
    private function calcularProximaAula($alunoId) {
        // Buscar turmas do aluno
        $turmas = $this->db->fetchAll("
            SELECT t.*, i.data_inscricao
            FROM turmas t
            JOIN inscricoes i ON t.id = i.turma_id
            WHERE i.aluno_id = ? AND i.status = 'ativa' AND t.status = 'ativa'
        ", [$alunoId]);
        
        if (empty($turmas)) {
            return null;
        }
        
        $diasSemana = [
            1 => 'Segunda',
            2 => 'Terça', 
            3 => 'Quarta',
            4 => 'Quinta',
            5 => 'Sexta',
            6 => 'Sábado',
            7 => 'Domingo'
        ];
        
        $proximaAula = null;
        $menorDiferenca = PHP_INT_MAX;
        
        foreach ($turmas as $turma) {
            $proximaData = $this->calcularProximaDataPorDiaSemana($turma['dia_semana']);
            $diferenca = strtotime($proximaData) - time();
            
            if ($diferenca > 0 && $diferenca < $menorDiferenca) {
                $menorDiferenca = $diferenca;
                $proximaAula = [
                    'nome' => $turma['nome'],
                    'dia_semana_nome' => $diasSemana[$turma['dia_semana']],
                    'proxima_data' => $proximaData,
                    'horario_inicio' => $turma['horario_inicio'],
                    'horario_fim' => $turma['horario_fim']
                ];
            }
        }
        
        return $proximaAula;
    }
    
    private function calcularProximaDataPorDiaSemana($diaSemana) {
        $hoje = new DateTime();
        $diaAtual = $hoje->format('N'); // 1 = segunda, 7 = domingo
        
        if ($diaSemana == $diaAtual) {
            // Se é hoje, verificar se já passou o horário
            return $hoje->format('Y-m-d');
        } elseif ($diaSemana > $diaAtual) {
            // Se é ainda nesta semana
            $diasParaAdicionar = $diaSemana - $diaAtual;
        } else {
            // Se é na próxima semana
            $diasParaAdicionar = (7 - $diaAtual) + $diaSemana;
        }
        
        $proximaData = clone $hoje;
        $proximaData->add(new DateInterval("P{$diasParaAdicionar}D"));
        
        return $proximaData->format('Y-m-d');
    }
    
    private function calcularEstatisticasPresenca($alunoId) {
        // Buscar a turma principal do aluno (primeira turma ou com mais presenças)
        $turmaPrincipal = $this->db->fetch("
            SELECT t.nome, t.id,
                   COUNT(p.id) as total_aulas,
                   SUM(CASE WHEN p.presente = 0 THEN 1 ELSE 0 END) as faltas
            FROM turmas t
            JOIN inscricoes i ON t.id = i.turma_id
            LEFT JOIN presencas p ON t.id = p.turma_id AND p.aluno_id = i.aluno_id
            WHERE i.aluno_id = ? AND i.status = 'ativa'
            GROUP BY t.id, t.nome
            ORDER BY total_aulas DESC
            LIMIT 1
        ", [$alunoId]);
        
        if (!$turmaPrincipal || $turmaPrincipal['total_aulas'] == 0) {
            return null;
        }
        
        return [
            'turma_principal' => $turmaPrincipal['nome'],
            'total_aulas' => (int)$turmaPrincipal['total_aulas'],
            'faltas' => (int)$turmaPrincipal['faltas']
        ];
    }
} 