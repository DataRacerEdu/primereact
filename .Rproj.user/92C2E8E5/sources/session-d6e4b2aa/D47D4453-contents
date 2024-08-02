export const withIconTemplate = (option, iconClass) => {
    return (
        <div className="flex align-items-center" style={{display: 'flex'}}>
            <img
                alt={option.title}
                src="https://primefaces.org/cdn/primereact/images/flag/flag_placeholder.png"
                className={`mr-2 ${iconClass}${option.item.toLowerCase()}`}
                style={{ width: '20px', marginRight: '5px' }} />
            <div>{option.title}</div>
        </div>
    );
};

export const selectedWithIconTemplate = (option, iconClass, placeholder) => {
    if (option) {
        return (
            <div className="flex align-items-center" style={{ display: "flex", justifyContent: "center"}}>
                <img alt={option.titile} src="https://primefaces.org/cdn/primereact/images/flag/flag_placeholder.png" className={`mr-2 ${iconClass}${option.item.toLowerCase()}`} style={{ width: '20px', marginRight: '5px' }} />
                <div>{option.title}</div>
            </div>
        );
    }

    return <span>{placeholder}</span>;
};
