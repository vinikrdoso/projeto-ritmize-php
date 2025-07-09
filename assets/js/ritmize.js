// ===== RITMIZE JavaScript =====

// Mobile Sidebar Toggle
function toggleMobileSidebar() {
  const sidebar = document.getElementById("mobileSidebar");
  const overlay = document.getElementById("mobileSidebarOverlay");

  if (sidebar && overlay) {
    sidebar.classList.toggle("show");
    overlay.classList.toggle("show");

    // Prevent body scroll when sidebar is open
    if (sidebar.classList.contains("show")) {
      document.body.style.overflow = "hidden";
    } else {
      document.body.style.overflow = "";
    }
  }
}

// Close mobile sidebar when clicking on navigation links
document.addEventListener("DOMContentLoaded", function () {
  const mobileNavLinks = document.querySelectorAll(".mobile-nav .nav-item");

  mobileNavLinks.forEach((link) => {
    link.addEventListener("click", function () {
      toggleMobileSidebar();
    });
  });

  // Close sidebar on escape key
  document.addEventListener("keydown", function (e) {
    if (e.key === "Escape") {
      const sidebar = document.getElementById("mobileSidebar");
      if (sidebar && sidebar.classList.contains("show")) {
        toggleMobileSidebar();
      }
    }
  });

  // Initialize any animations or dynamic content
  initializeDashboard();
});

// Initialize dashboard animations and dynamic content
function initializeDashboard() {
  // Animate attendance progress bars
  const progressBars = document.querySelectorAll(".attendance-progress");
  progressBars.forEach((bar) => {
    const width = bar.getAttribute("data-width") || "0%";
    setTimeout(() => {
      bar.style.width = width;
    }, 300);
  });

  // Add smooth scrolling for any anchor links
  const anchorLinks = document.querySelectorAll('a[href^="#"]');
  anchorLinks.forEach((link) => {
    link.addEventListener("click", function (e) {
      e.preventDefault();
      const target = document.querySelector(this.getAttribute("href"));
      if (target) {
        target.scrollIntoView({
          behavior: "smooth",
          block: "start",
        });
      }
    });
  });
}

// Format currency values
function formatCurrency(value, currency = "€") {
  return `${currency}${parseFloat(value).toFixed(2).replace(".", ",")}`;
}

// Format dates to Brazilian format
function formatDate(dateString) {
  const date = new Date(dateString);
  return date.toLocaleDateString("pt-BR", {
    weekday: "short",
    day: "2-digit",
    month: "2-digit",
    year: "numeric",
  });
}

// Show notification toast (for future use)
function showNotification(message, type = "info") {
  // Implementation for toast notifications
  console.log(`${type.toUpperCase()}: ${message}`);
}

// Handle responsive behavior
function handleResize() {
  const sidebar = document.getElementById("mobileSidebar");
  const overlay = document.getElementById("mobileSidebarOverlay");

  // Close mobile sidebar on desktop
  if (window.innerWidth >= 992) {
    if (sidebar && sidebar.classList.contains("show")) {
      sidebar.classList.remove("show");
      overlay.classList.remove("show");
      document.body.style.overflow = "";
    }
  }
}

// Add resize listener
window.addEventListener("resize", handleResize);

// Export functions for global use
window.ritmize = {
  toggleMobileSidebar,
  formatCurrency,
  formatDate,
  showNotification,
};
