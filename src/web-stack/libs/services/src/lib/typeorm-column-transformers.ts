export class ColumnNumericTransformerInt {
  to(data: number): number {
    return data;
  }

  from(data: string): number {
    return parseInt(data);
  }
}

export class ColumnNumericTransformerFloat {
  to(data: number): number {
    return data;
  }

  from(data: string): number {
    return parseFloat(data);
  }
}
