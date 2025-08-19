import type { FastifyReply, FastifyRequest } from "fastify";
import { getAuthenticatedUserFromRequest } from "../../utils/get-authenticated-user-from-request.ts";

type JWTPayload = {
  sub: string;
  role: "studante" | "manager";
};

export function checkUserRole(role: "studante" | "manager") {
  return async function (request: FastifyRequest, reply: FastifyReply) {
    const user = getAuthenticatedUserFromRequest(request);

    if (user.role !== role) {
      return reply.status(401).send();
    }
  };
}
