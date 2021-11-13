import { FastifyRequest as Request, FastifyReply as Reply } from 'fastify'
import { labaRugi, perubahanModal, snapshot, snapshotReport, findReport } from './service'
import * as DTO from './finance.dto';

type ResponseType = 'word' | 'json'

export type PostSnapshotRequest = Request<{
  Querystring: DTO.Snapshot.Marker
}>;

export type PostReportRequest = Request<{
  Body: DTO.CreateReport.Marker
}>

export type GetReportRequest = Request<{
  Querystring: DTO.FindReport.Marker
}>


export async function postReport(request: PostReportRequest, reply: Reply) {
  const options = request.body
  const result = await snapshotReport(options)
  reply.send(result)
}

export async function getReport(request: GetReportRequest, reply: Reply) {
  const options = request.query
  const report = await findReport(options)
  reply.send(report)
}
