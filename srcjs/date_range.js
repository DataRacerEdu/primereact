import { reactShinyInput } from 'reactR';
import React, { useState, useEffect } from "react";
import { Calendar } from 'primereact/calendar';
import "primereact/resources/themes/lara-light-cyan/theme.css";
import { convertToDateString } from "./utils/utils.js";


const DateRangeInput = ({ configuration, value, setValue }) => {
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

  const [dates, setDates] = useState(value ? value.map(date => new Date(date)) : null);
  const [clearClicked, setClearClicked] = useState(false);

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
        onChange={(e) => setDates((e.value))}
        onHide={() => {
          if (dates && dates.every(date => date)) {
            setValue(dates.map(date => convertToDateString(date)));
          } else {
            setValue([null, null]);
          }
        }}
        selectionMode="range"
        readOnlyInput
        onClearButtonClick={() => {
          setClearClicked(true);
        }}
        hideOnRangeSelection
        showButtonBar
        placeholder={config.placeholder || "Select Date Range"}
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

