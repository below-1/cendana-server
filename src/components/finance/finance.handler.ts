import { FastifyRequest as Request, FastifyReply as Reply } from 'fastify'
import { labaRugi, perubahanModal } from './service'
import * as DTO from './finance.dto';

type ResponseType = 'word' | 'json'

export type GetLabaRugi = Request<{ 
  Querystring: DTO.LabaRugi.Marker,
  Params: DTO.RespType.Marker
}>;

export type GetPerubahanModal = Request<{ 
  Querystring: DTO.PerubahanModal.Marker,
  Params: DTO.RespType.Marker
}>;

export async function getLabaRugi(request: GetLabaRugi, reply: Reply) {
  const { type } = request.params
  const result = await labaRugi(type, request.query)
  if (type == DTO.RespTypeEnum.WORD) {
    reply.type('application/vnd.openxmlformats-officedocument.wordprocessingml.document')
    console.log(result)
  }
  reply.send(result)
}

export async function getPerubahanModal(request: GetPerubahanModal, reply: Reply) {
  const { type } = request.params
  const result = await perubahanModal(type, request.query)
  if (type == DTO.RespTypeEnum.WORD) {
    reply.type('application/vnd.openxmlformats-officedocument.wordprocessingml.document')
    console.log(result)
  }
  reply.send(result)
}