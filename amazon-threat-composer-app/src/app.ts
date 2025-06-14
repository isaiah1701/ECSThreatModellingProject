import { ThreatModel } from './components/ThreatModel';
import { ThreatCanvas } from './components/ThreatCanvas';
import { ComponentLibrary } from './components/ComponentLibrary';
import { ThreatService } from './services/ThreatService';
import { ExportService } from './services/ExportService';

class App {
    private threatModel: ThreatModel;
    private threatCanvas: ThreatCanvas;
    private componentLibrary: ComponentLibrary;
    private threatService: ThreatService;
    private exportService: ExportService;

    constructor() {
        this.threatModel = new ThreatModel();
        this.threatCanvas = new ThreatCanvas();
        this.componentLibrary = new ComponentLibrary();
        this.threatService = new ThreatService();
        this.exportService = new ExportService();
    }

    public initialize(): void {
        this.setupUI();
        this.loadThreats();
    }

    private setupUI(): void {
        // Initialize UI components
        this.componentLibrary.createButton('Add Threat', this.addThreat.bind(this));
        this.componentLibrary.createButton('Export Model', this.exportModel.bind(this));
        // Additional UI setup can be done here
    }

    private loadThreats(): void {
        // Load existing threats and update the canvas
        const threats = this.threatService.fetchThreats();
        this.threatModel.addThreats(threats);
        this.threatCanvas.render(this.threatModel);
    }

    private addThreat(): void {
        // Logic to add a new threat
        const newThreat = this.threatService.createThreat();
        this.threatModel.addThreat(newThreat);
        this.threatCanvas.update(this.threatModel);
    }

    private exportModel(): void {
        // Logic to export the threat model
        const exportedData = this.exportService.exportToJSON(this.threatModel);
        console.log('Exported Data:', exportedData);
    }
}

const app = new App();
app.initialize();