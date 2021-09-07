require('module-alias/register')
if (process.env.NODE_ENV == 'development') {
  require('dotenv').config()
}
import { createServer } from './server'

async function main() {
  const server = createServer()
  const port: number = process.env.PORT ? parseInt(process.env.PORT) : 5000
  server.listen(port, (err, address) => {
    if (err) {
      console.log(err)
      process.exit(1)
    }
    server.swagger()
    server.blipp()
    server.log.info(`listening at ${address}`)
  })
}

main();