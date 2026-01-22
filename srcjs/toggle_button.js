import { reactShinyInput } from 'reactR';
import React, { useState, useEffect } from "react";
import { ToggleButton } from 'primereact/togglebutton';
import { registerLanguageHandler } from "./utils/languageHandler.js";


const ToggleButtonInput = ({ configuration, value, setValue }) => {
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

  // Translation support
  const [lang_selected, setlang_selected] = useState(configuration.default_langauge);
  const [onLabel, setOnLabel] = useState(() => {
    return configuration.translation_list?.[configuration.default_langauge]?.[configuration.onLabel] || configuration.onLabel || 'On';
  });
  const [offLabel, setOffLabel] = useState(() => {
    return configuration.translation_list?.[configuration.default_langauge]?.[configuration.offLabel] || configuration.offLabel || 'Off';
  });

  // Register for language changes using shared handler
  useEffect(() => {
    if (!config.message_handler_id_from_shiny) return;
    const cleanup = registerLanguageHandler(config.message_handler_id_from_shiny, (newLanguage) => {
      setlang_selected(newLanguage);
    });
    return cleanup;
  }, [config.message_handler_id_from_shiny]);

  // Translate labels when language changes
  useEffect(() => {
    const translatedOnLabel = config.translation_list?.[lang_selected]?.[config.onLabel] || config.onLabel || 'On';
    const translatedOffLabel = config.translation_list?.[lang_selected]?.[config.offLabel] || config.offLabel || 'Off';
    setOnLabel(translatedOnLabel);
    setOffLabel(translatedOffLabel);
  }, [lang_selected, config.onLabel, config.offLabel, config.translation_list]);

  return (
    <div className="card flex justify-content-center">
      <ToggleButton
        onLabel={onLabel}
        offLabel={offLabel}
        onIcon={config.onIcon || 'pi pi-check'}
        offIcon={config.offIcon || 'pi pi-times'}
        disabled={config.disabled}
        checked={value}
        onChange={(e) => setValue(e.value)}
        className={`${config.class || ''} w-9rem`}
        {...(config.width ? { style: { width: config.width } } : {})}
      />
    </div>
  );
};

export default function initToggleButtonInput(){
  return reactShinyInput(
    '.toggle_button',
    'primereact.toggle_button',
    ToggleButtonInput
  );
}
