import createError from 'fastify-error'

export const ROCNotFound = createError(
  'FST_ROC_NOT_FOUND',
  "ROC(id=%s) can't be found",
  500
)