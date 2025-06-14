export interface ThreatModel {
    id: string;
    name: string;
    description: string;
    threats: Threat[];
}

export interface AssetModel {
    name: string;
    value: number;
    owner: string;
}

export interface MitigationModel {
    type: string;
    effectiveness: number;
    associatedThreats: Threat[];
}

export interface Threat {
    type: string;
    severity: string;
    impact: string;
}