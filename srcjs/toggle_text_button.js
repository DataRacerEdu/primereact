import { reactShinyInput } from 'reactR';
import React, { useState, useEffect } from "react";
import { SelectButton } from 'primereact/selectbutton';
import { registerLanguageHandler } from "./utils/languageHandler.js";

const ToggleTextButtonInput = ({ configuration, value, setValue }) => {
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
  const [itemOptions, setItemOptions] = useState(() => {
    return (configuration.options || []).map(val => ({
      value: val,
      name: configuration.translation_list?.[configuration.default_langauge]?.[val] || val,
    }));
  });

  // Register for language changes using shared handler
  useEffect(() => {
    if (!config.message_handler_id_from_shiny) return;
    const cleanup = registerLanguageHandler(config.message_handler_id_from_shiny, (newLanguage) => {
      setlang_selected(newLanguage);
    });
    return cleanup;
  }, [config.message_handler_id_from_shiny]);

  // Render options
  useEffect(() => {
    // Dynamically create `itemOptions`
    const options = (config.options || []).map(val => ({
        value: val,
        name: config.translation_list?.[lang_selected]?.[val] || val,
    }));
    setItemOptions(options);
  }, [lang_selected, config.options, config.translation_list]);

  return (
    <div className="card flex justify-content-center">
      <SelectButton
        value={value.value}
        onChange={(e) => {
          setValue({value: e.value, name: config.translation_list?.[lang_selected]?.[e.value] || e.value});
        }}
        optionLabel="name"
        options={itemOptions}
        allowEmpty={false}
        multiple={false}
        disabled={config.disabled}
      />
    </div>
  );
};

export default function initToggleTextButtonInput(){
  return reactShinyInput(
    '.toggle_text_button',
    'primereact.toggle_text_button',
    ToggleTextButtonInput
  );
}
