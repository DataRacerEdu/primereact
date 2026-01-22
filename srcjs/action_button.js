import { reactShinyInput } from 'reactR';
import { useState, useEffect } from "react";
import { Button } from 'primereact/button';
import 'primeicons/primeicons.css';
import "primereact/resources/themes/lara-light-cyan/theme.css";
import { registerLanguageHandler } from "./utils/languageHandler.js";

const ActionButtonInput = ({ configuration, value, setValue }) => {
  // Store merged configuration in state for partial updates
  const [config, setConfig] = useState(() => ({ ...configuration }));

  // Merge incoming configuration updates (supports partial updates)
  useEffect(() => {
    if (!configuration) return;
    setConfig(prev => {
      const merged = { ...prev };
      for (const key in configuration) {
        if (configuration[key] !== undefined) {
          merged[key] = configuration[key];
        }
      }
      return merged;
    });
  }, [JSON.stringify(configuration)]);

  const [lang_selected, setlang_selected] = useState(configuration.default_langauge);
  const [label, setLabel] = useState(() => {
    return configuration.translation_list?.[configuration.default_langauge]?.[configuration.label] || configuration.label;
  });

  // Register for language changes using shared handler
  useEffect(() => {
    if (!config.message_handler_id_from_shiny) return;
    const cleanup = registerLanguageHandler(config.message_handler_id_from_shiny, (newLanguage) => {
      setlang_selected(newLanguage);
    });
    return cleanup;
  }, [config.message_handler_id_from_shiny]);

  // Render label with translation
  useEffect(() => {
    // Dynamically create translate text
    const translated_text = config.translation_list?.[lang_selected]?.[config.label] || config.label;
    setLabel(translated_text);
  }, [lang_selected, config.label, config.translation_list]);

  return (
    <div className="card flex justify-content-center">
      <Button
        label={label}
        icon={config.icon}
        iconPos={config.iconPos}
        disabled={config.disabled}
        rounded={config.rounded}
        text={config.text}
        raised={config.raised}
        outlined={config.outlined}
        size={config.size}
        onClick={() => setValue(value + 1)}
      />
    </div>
  )
};

export default function initActionButton(){
  return reactShinyInput(
    '.action_button',
    'primereact.action_button',
    ActionButtonInput);
}

