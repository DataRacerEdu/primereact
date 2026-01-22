// Shared language change handler
// Uses custom DOM events to allow multiple components to listen

const registeredHandlers = new Set();

export function registerLanguageHandler(handlerId, callback) {
  // Register the Shiny handler only once per handlerId
  if (!registeredHandlers.has(handlerId)) {
    registeredHandlers.add(handlerId);

    if (window.Shiny) {
      Shiny.addCustomMessageHandler(handlerId, function(newLanguage) {
        // Dispatch a custom event that all components can listen to
        const event = new CustomEvent(`primereact-language-${handlerId}`, {
          detail: { language: newLanguage }
        });
        window.dispatchEvent(event);
      });
    }
  }

  // Add event listener for this component
  const eventHandler = (e) => callback(e.detail.language);
  window.addEventListener(`primereact-language-${handlerId}`, eventHandler);

  // Return cleanup function
  return () => {
    window.removeEventListener(`primereact-language-${handlerId}`, eventHandler);
  };
}
