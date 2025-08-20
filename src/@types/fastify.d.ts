import "fastify";

declare module "fastify" {
  export interface FastifyRequest {
    user?: {
      sub: string;
      role: "studante" | "manager";
    };
  }
}
