import { prisma } from '@cend/commons/prisma'

import { 
  format, 
  parse, 
  lastDayOfMonth, 
  setMonth, 
  setYear, 
  setDate, 
  addMonths
} from 'date-fns'

interface RemoveOptions {
  month: number;
  year: number;
}

export async function snapshot() {
  
}

// This function remove snapshots starting
// from specified date till
export async function removeSnapshot() {

}