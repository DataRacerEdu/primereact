import { reactShinyInput } from 'reactR';
import { useState, useEffect } from "react";
import { MultiSelect } from 'primereact/multiselect';
import "primereact/resources/themes/lara-light-cyan/theme.css";
import { withIconTemplate } from "./utils/selectIconTemplate.js";


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

  const [lang_selected, setlang_selected] = useState(config.default_langauge);
  const [placeholder, setPlaceholder] = useState(config.placeholder);

  // Register the Shiny custom message handler for 'language_changed'
  useEffect(() => {
    if (window.Shiny) {
      Shiny.addCustomMessageHandler(config.message_handler_id_from_shiny, function(newLanguage) {
        setlang_selected(newLanguage);
      });
    }
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
