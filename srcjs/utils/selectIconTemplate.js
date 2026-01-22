export const withIconTemplate = (option, iconClass) => {
    return (
        <div style={{ display: 'flex', alignItems: 'center' }}>
            <img
                alt={option.title}
                src="https://primefaces.org/cdn/primereact/images/flag/flag_placeholder.png"
                className={`${iconClass}${option.item.toLowerCase()}`}
                style={{ width: '20px', height: '20px', marginRight: '8px', objectFit: 'contain' }} />
            <span>{option.title}</span>
        </div>
    );
};

export const selectedWithIconTemplate = (option, iconClass, placeholder) => {
    if (option) {
        return (
            <div style={{ display: 'flex', alignItems: 'center' }}>
                <img
                    alt={option.title}
                    src="https://primefaces.org/cdn/primereact/images/flag/flag_placeholder.png"
                    className={`${iconClass}${option.item.toLowerCase()}`}
                    style={{ width: '20px', height: '20px', marginRight: '8px', objectFit: 'contain' }} />
                <span>{option.title}</span>
            </div>
        );
    }
    return <span>{placeholder}</span>;
};
