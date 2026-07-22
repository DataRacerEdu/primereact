import { reactShinyInput } from 'reactR';
import React, { useState, useEffect } from "react";
import { Calendar } from 'primereact/calendar';
import "primereact/resources/themes/lara-light-cyan/theme.css";
import { convertToDateString } from "./utils/utils.js";
import { registerLanguageHandler } from "./utils/languageHandler.js";


export const DateInput = ({ configuration, value, setValue }) => {
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
  const [placeholder, setPlaceholder] = useState(() => {
    return configuration.translation_list?.[configuration.default_langauge]?.[configuration.placeholder] || configuration.placeholder || "Select Date";
  });

  // Register for language changes using shared handler
  useEffect(() => {
    if (!config.message_handler_id_from_shiny) return;
    const cleanup = registerLanguageHandler(config.message_handler_id_from_shiny, (newLanguage) => {
      setlang_selected(newLanguage);
    });
    return cleanup;
  }, [config.message_handler_id_from_shiny]);

  // Translate placeholder when language changes
  useEffect(() => {
    const translatedPlaceholder = config.translation_list?.[lang_selected]?.[config.placeholder] || config.placeholder || "Select Date";
    setPlaceholder(translatedPlaceholder);
  }, [lang_selected, config.placeholder, config.translation_list]);

  const [date, setDate] = useState(value ? new Date(value) : null);
  const [clearClicked, setClearClicked] = useState(false);

  useEffect(() => {
    if (clearClicked) {
      setDate(null);
      setClearClicked(false);
      return;
    }

    if (value) {
      setDate(new Date(value));
      return;
    }

    if (!value) {
      setDate(null);
      return;
    }
  }, [value]);

  return (
    <div className="card flex justify-content-center">
      <Calendar
        value={date}
        onChange={(e) => setDate(e.value)}
        dateFormat={config.dateFormat || "mm/dd/yy"}
        readOnlyInput={config.readonly !== false}
        keepInvalid={config.readonly === false}
        onHide={() => {
          if (date instanceof Date && !isNaN(date.getTime())) {
            setValue(convertToDateString(date));
          } else {
            // Incomplete/invalid typed text: drop it and report no selection
            if (date) setDate(null);
            setValue(null);
          }
        }}
        onClearButtonClick={() => {
          setClearClicked(true);
        }}
        showButtonBar
        placeholder={placeholder}
        showIcon
        className={`${config.class || ''} w-full`}
        minDate={config.minDate ? new Date(config.minDate) : undefined}
        maxDate={config.maxDate ? new Date(config.maxDate) : undefined}
        style={config.width ? { width: config.width } : undefined}
      />
    </div>
  )
};

export default function initDateInput(){
  return reactShinyInput(
    '.date_input',
    'primereact.date_input',
    DateInput
  );
}
