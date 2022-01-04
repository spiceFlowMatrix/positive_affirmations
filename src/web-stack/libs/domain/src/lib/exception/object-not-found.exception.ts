export class ObjectNotFoundException extends Error {
  constructor(entityName: string, entityId: number | string, operationName: string, operationData: any) {
    super(`${entityName}(${entityId}) not found. ${operationName}(${JSON.stringify(operationData)}) failed.`);
  }
}
