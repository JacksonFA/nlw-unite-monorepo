import os from 'os';
import { FastifyInstance } from "fastify";
import { ZodTypeProvider } from "fastify-type-provider-zod";

export const health = async (app: FastifyInstance) => {
  app
    .withTypeProvider<ZodTypeProvider>()
    .get('/healthz', async (_, reply) => {
      return reply.status(200).send(`Pass.In API running on ${os.hostname()}`)
    })
}