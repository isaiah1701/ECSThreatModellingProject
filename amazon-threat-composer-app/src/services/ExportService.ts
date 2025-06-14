export class ExportService {
    exportToJSON(threatModel: any): string {
        return JSON.stringify(threatModel, null, 2);
    }

    exportToCSV(threatModel: any): string {
        const headers = Object.keys(threatModel[0]).join(',');
        const rows = threatModel.map((model: any) => Object.values(model).join(',')).join('\n');
        return `${headers}\n${rows}`;
    }
}