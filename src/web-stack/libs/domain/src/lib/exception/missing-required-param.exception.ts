export class MissingRequiredParamException extends Error {
  constructor(operationName: string, paramName: string, paramType: string) {
    super(
      `Missing parameter for operation (${operationName}){${paramName}:${paramType}}`
    );
  }
}
