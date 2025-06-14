export class Asset {
    name: string;
    value: number;
    owner: string;

    constructor(name: string, value: number, owner: string) {
        this.name = name;
        this.value = value;
        this.owner = owner;
    }
}