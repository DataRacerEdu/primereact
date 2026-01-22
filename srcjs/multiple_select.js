import { reactShinyInput } from 'reactR';
import { useState, useEffect } from "react";
import { MultiSelect } from 'primereact/multiselect';
import "primereact/resources/themes/lara-light-cyan/theme.css";
import { withIconTemplate } from "./utils/selectIconTemplate.js";
import { registerLanguageHandler } from "./utils/languageHandler.js";


const MultiSelectDropdown = ({ configuration, value, setValue }) => {
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
  const [placeholder, setPlaceholder] = useState(() => {
    return configuration.translation_list?.[configuration.default_langauge]?.[configuration.placeholder] || configuration.placeholder;
  });

  // Register for language changes using shared handler
  useEffect(() => {
    if (!config.message_handler_id_from_shiny) return;
    const cleanup = registerLanguageHandler(config.message_handler_id_from_shiny, (newLanguage) => {
      setlang_selected(newLanguage);
    });
    return cleanup;
  }, [config.message_handler_id_from_shiny]);

  // Render placeholder
  useEffect(() => {
    // Dynamically create translate text
    const translated_text = config.translation_list?.[lang_selected]?.[config.placeholder] || config.placeholder;
    setPlaceholder(translated_text);
  }, [lang_selected, config.placeholder, config.translation_list]);


  return (
    <div className="card flex justify-content-center">
      <MultiSelect
        value={value}
        options={config.options || []}
        onChange={(e) => e.value === undefined || e.value.length < 1 ? setValue(null) : setValue(e.value)}
        optionLabel="title"
        placeholder={placeholder || "Select value(s)"}
        className={`${config.class || ''} w-full`}
        {...(config.width ? { style: { width: config.width } } : {})}
        {...(config.iconClass ? { itemTemplate: (option) => withIconTemplate(option, config.iconClass) } : {})}
        display="chip"
        filter={config.filter}
        filterInputAutoFocus={config.filterInputAutoFocus}
      />
    </div>
  );
};

export default function initMultiSelectInput() {
  return reactShinyInput(
    '.multiple_select',
    'primereact.multiple_select',
    MultiSelectDropdown
  );
}
