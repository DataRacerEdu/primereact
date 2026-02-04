import initActionButton from "./action_button.js";
import initDateRangeInput from "./date_range.js";
import initDateInput from "./date_input.js";
import initToggleButtonInput from "./toggle_button.js";
import initMultiSelectInput from "./multiple_select.js";
import initSelectInput from "./select.js";
import initToggleTextButtonInput from "./toggle_text_button.js";

// Embedded country flags CSS
import "../inst/www/primereact/icons/countries/countries.css";

// Bootstrap override fixes - injected after DOM ready to ensure it loads after Bootstrap
const primereactFixesCSS = `
/* PrimeReact Bootstrap Override Fixes */
.p-button { border-radius: var(--border-radius) !important; }
.p-button.p-button-rounded { border-radius: 2rem !important; }
.p-togglebutton { border-radius: var(--border-radius) !important; }
.p-selectbutton .p-button { border-radius: 0 !important; }
.p-selectbutton .p-button:first-of-type { border-top-left-radius: var(--border-radius) !important; border-bottom-left-radius: var(--border-radius) !important; }
.p-selectbutton .p-button:last-of-type { border-top-right-radius: var(--border-radius) !important; border-bottom-right-radius: var(--border-radius) !important; }
.p-dropdown { border-radius: var(--border-radius) !important; }
.p-multiselect { border-radius: var(--border-radius) !important; }
.p-calendar .p-inputtext { border-top-left-radius: var(--border-radius) !important; border-bottom-left-radius: var(--border-radius) !important; border-top-right-radius: 0 !important; border-bottom-right-radius: 0 !important; }
.p-calendar .p-datepicker-trigger { border-top-left-radius: 0 !important; border-bottom-left-radius: 0 !important; border-top-right-radius: var(--border-radius) !important; border-bottom-right-radius: var(--border-radius) !important; }
.p-inputtext { border-radius: var(--border-radius) !important; }
`;

// Inject CSS after DOM is ready (after Bootstrap loads)
if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', injectFixesCSS);
} else {
  injectFixesCSS();
}

function injectFixesCSS() {
  const style = document.createElement('style');
  style.textContent = primereactFixesCSS;
  document.head.appendChild(style);
}

// Initialize inputs
initActionButton();
initDateRangeInput();
initDateInput();
initToggleButtonInput();
initMultiSelectInput();
initSelectInput();
initToggleTextButtonInput();
