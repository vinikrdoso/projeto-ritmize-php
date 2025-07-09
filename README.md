# 🥁 RITMIZE - Sistema de Gestão de Escola de Música

Sistema web para gestão de alunos, aulas, pagamentos e notificações de uma escola de música.

## 📋 Funcionalidades

- **Dashboard** - Visão geral com cards de pagamentos, aulas e notificações
- **Login/Logout** - Sistema de autenticação
- **Perfil** - Gestão de dados pessoais e foto
- **Aulas** - Histórico de presença e turmas
- **Financeiro** - Gestão de mensalidades e pagamentos
- **Notificações** - Sistema de avisos e comunicados

## 📁 Estrutura do Projeto

```
ritmize/
├── assets/                 # Recursos estáticos
│   ├── css/               # Estilos CSS
│   ├── js/                # JavaScript
│   └── img/               # Imagens e ícones
├── system/                 # Sistema MVC
│   ├── core/              # Classes principais
│   ├── controllers/       # Controladores
│   └── models/            # Modelos
├── templates/              # Templates Twig
├── vendor/                 # Dependências Composer
├── public/                 # Arquivos públicos
├── index.php              # Dashboard principal
├── login.php              # Sistema de login
├── logout.php             # Sistema de logout
├── perfil.php             # Página de perfil
├── aulas.php              # Página de aulas
├── financeiro.php         # Página financeira
├── composer.json          # Dependências
└── README.md              # Este arquivo
```

## 🎯 Como Usar

1. **Acesse o sistema**: `http://localhost/ritmize/`
2. **Faça login** com as credenciais fornecidas
3. **Navegue pelas seções**:
   - Dashboard: Visão geral
   - Perfil: Dados pessoais
   - Aulas: Histórico de presença
   - Financeiro: Pagamentos

## 🔧 Configuração

### Banco de Dados

Edite `system/core/Database.php`:

```php
private $host = 'localhost';
private $dbname = 'ritmize';
private $username = 'seu_usuario';
private $password = 'sua_senha';
```
---

**RITMIZE** - Sistema de Gestão de Escola de Música 🎵 