import carbone from 'carbone'
import { join } from 'path'

interface PrintOptions {
  path: string;
  data: any;
}

export async function print(options: PrintOptions) {
  const fullPath = join(process.cwd(), 'report', options.path + '.docx')
  return new Promise<Buffer>((resolve, reject) => {
    carbone.render(fullPath, options.data, (err, result) => {
      if (err) {
        reject(err)
        return
      }
      resolve(result as Buffer)
    })
  })
}
