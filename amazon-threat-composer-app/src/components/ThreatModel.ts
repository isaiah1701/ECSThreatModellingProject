class ThreatModel {
    id: string;
    name: string;
    description: string;
    threats: Threat[];

    constructor(id: string, name: string, description: string) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.threats = [];
    }

    addThreat(threat: Threat): void {
        this.threats.push(threat);
    }

    removeThreat(threatId: string): void {
        this.threats = this.threats.filter(threat => threat.id !== threatId);
    }
} 

export default ThreatModel;