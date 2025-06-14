export class ThreatService {
    private threats: Threat[] = [];

    constructor() {
        // Initialize with some default threats if necessary
    }

    public fetchThreats(): Threat[] {
        return this.threats;
    }

    public createThreat(threat: Threat): void {
        this.threats.push(threat);
    }

    public updateThreat(updatedThreat: Threat): void {
        const index = this.threats.findIndex(threat => threat.id === updatedThreat.id);
        if (index !== -1) {
            this.threats[index] = updatedThreat;
        }
    }

    public deleteThreat(threatId: string): void {
        this.threats = this.threats.filter(threat => threat.id !== threatId);
    }
}