export class ComponentLibrary {
    createButton(label: string, onClick: () => void): HTMLButtonElement {
        const button = document.createElement('button');
        button.innerText = label;
        button.onclick = onClick;
        return button;
    }

    createForm(fields: { label: string; type: string; name: string }[], onSubmit: (data: Record<string, any>) => void): HTMLFormElement {
        const form = document.createElement('form');
        
        fields.forEach(field => {
            const label = document.createElement('label');
            label.innerText = field.label;
            const input = document.createElement('input');
            input.type = field.type;
            input.name = field.name;
            form.appendChild(label);
            form.appendChild(input);
        });

        form.onsubmit = (event) => {
            event.preventDefault();
            const formData: Record<string, any> = {};
            fields.forEach(field => {
                formData[field.name] = (form.elements[field.name] as HTMLInputElement).value;
            });
            onSubmit(formData);
        };

        return form;
    }

    createTextArea(name: string, placeholder: string): HTMLTextAreaElement {
        const textArea = document.createElement('textarea');
        textArea.name = name;
        textArea.placeholder = placeholder;
        return textArea;
    }
}