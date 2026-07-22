import { reactShinyInput } from 'reactR';
import React, { useState, useEffect, useRef } from "react";
import { Calendar } from 'primereact/calendar';
import "primereact/resources/themes/lara-light-cyan/theme.css";
import { convertToDateString } from "./utils/utils.js";
import { registerLanguageHandler } from "./utils/languageHandler.js";


export const DateRangeInput = ({ configuration, value, setValue }) => {
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
    return configuration.translation_list?.[configuration.default_langauge]?.[configuration.placeholder] || configuration.placeholder || "Select Date Range";
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
    const translatedPlaceholder = config.translation_list?.[lang_selected]?.[config.placeholder] || config.placeholder || "Select Date Range";
    setPlaceholder(translatedPlaceholder);
  }, [lang_selected, config.placeholder, config.translation_list]);

  const [dates, setDates] = useState(value ? value.map(date => new Date(date)) : null);
  const [clearClicked, setClearClicked] = useState(false);
  // True while the input holds typed text that doesn't parse as a range yet;
  // the raw string must never reach `dates`, since a re-render with a string
  // value makes PrimeReact mangle the input text in range mode
  const invalidTextRef = useRef(false);

  useEffect(() => {
    if (clearClicked) {
      setDates(null);
      setClearClicked(false);
      return;
    }

    if (value) {
      if(!value.some(item => item !== null)) {
        setDates(null);
        return;
      } else {
        setDates(value.map(date => new Date(date)));
        return;
      }
    }

    if(!value) {
      setDates(null);
      return;
    }
  }, [value]);

  return (
    <div className="card flex justify-content-center">
      <Calendar
        value={dates}
        onChange={(e) => {
          if (typeof e.value === 'string') {
            invalidTextRef.current = true;
          } else {
            invalidTextRef.current = false;
            setDates(e.value);
          }
        }}
        onHide={() => {
          if (!invalidTextRef.current && Array.isArray(dates) && dates.length && dates.every(date => date instanceof Date && !isNaN(date.getTime()))) {
            setValue(dates.map(date => convertToDateString(date)));
          } else {
            // Incomplete/invalid typed text: drop it and report no selection
            invalidTextRef.current = false;
            setDates(null);
            setValue([null, null]);
          }
        }}
        selectionMode="range"
        dateFormat={config.dateFormat || "mm/dd/yy"}
        readOnlyInput={config.readonly !== false}
        keepInvalid={config.readonly === false}
        onClearButtonClick={() => {
          setClearClicked(true);
        }}
        hideOnRangeSelection
        showButtonBar
        placeholder={placeholder}
        showIcon
        showMinMaxRange
        className={`${config.class || ''} w-full`}
        minDate={config.minDate ? new Date(config.minDate) : undefined}
        maxDate={config.maxDate ? new Date(config.maxDate) : undefined}
        style={config.width ? { width: config.width } : undefined}
      />
    </div>
  )
};

export default function initDateRangeInput(){
  return reactShinyInput(
    '.date_range',
    'primereact.date_range',
    DateRangeInput
  );
}

