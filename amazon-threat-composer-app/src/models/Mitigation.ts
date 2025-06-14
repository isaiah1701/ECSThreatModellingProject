export class Mitigation {
    type: string;
    effectiveness: number;
    associatedThreats: string[];

    constructor(type: string, effectiveness: number, associatedThreats: string[]) {
        this.type = type;
        this.effectiveness = effectiveness;
        this.associatedThreats = associatedThreats;
    }

    getMitigationDetails() {
        return {
            type: this.type,
            effectiveness: this.effectiveness,
            associatedThreats: this.associatedThreats
        };
    }
}