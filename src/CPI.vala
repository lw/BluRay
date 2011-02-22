/*
 * BluRay - a simple sample implementation of Blu-ray Disc specifications
 * Copyright (C) 2011  Luca Wehrstedt

 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.

 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.

 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

using Gee;

namespace BluRay
{
	class CPI : Object
	{
		public uint8 CPIType { get; set; }

		public ArrayList<uint16> StreamPID { get; set; }

		public ArrayList<uint8> EPStreamType { get; set; }

		public ArrayList<ArrayList<uint32>> RefToEPFineID { get; set; }

		public ArrayList<ArrayList<uint16>> PTSEPCoarse { get; set; }

		public ArrayList<ArrayList<uint32>> SPNEPCoarse { get; set; }

		public ArrayList<ArrayList<uint8>> ReservedEPFine { get; set; }

		public ArrayList<ArrayList<uint8>> IEndPositionOffset { get; set; }

		public ArrayList<ArrayList<uint16>> PTSEPFine { get; set; }

		public ArrayList<ArrayList<uint32>> SPNEPFine { get; set; }

		public CPI.from_bit_input_stream (BitInputStream input_stream) throws ParseError
		{
			try
			{
				uint32 Length = input_stream.read_bits_as_uint32 (32);

				int64 Position = input_stream.tell (); // Needed to seek

				if (Length != 0)
				{
					input_stream.skip_bits (12);

					CPIType = input_stream.read_bits_as_uint8 (4);

					input_stream.skip_bits (8);

					uint8 NumberOfStreamPIDEntries = input_stream.read_bits_as_uint8 (8);

					StreamPID = new ArrayList<uint16> ();
					EPStreamType = new ArrayList<uint8> ();

					ArrayList<uint16> NumberOfEPCoarseEntries = new ArrayList<uint16> ();
					ArrayList<uint32> NumberOfEPFineEntries = new ArrayList<uint32> ();
					ArrayList<uint32> EPMapForOneStreamPIDStartAddress = new ArrayList<uint32> ();

					for (int i = 0; i < NumberOfStreamPIDEntries; i += 1)
					{
						StreamPID.add (input_stream.read_bits_as_uint16 (16));

						input_stream.skip_bits (10);

						EPStreamType.add (input_stream.read_bits_as_uint8 (4));
						NumberOfEPCoarseEntries.add (input_stream.read_bits_as_uint16 (16));
						NumberOfEPFineEntries.add (input_stream.read_bits_as_uint32 (18));
						EPMapForOneStreamPIDStartAddress.add (input_stream.read_bits_as_uint32 (32));
					}

					RefToEPFineID = new ArrayList<ArrayList<uint32>> ();
					PTSEPCoarse = new ArrayList<ArrayList<uint16>> ();
					SPNEPCoarse = new ArrayList<ArrayList<uint32>> ();
					ReservedEPFine = new ArrayList<ArrayList<uint8>> ();
					IEndPositionOffset = new ArrayList<ArrayList<uint8>> ();
					PTSEPFine = new ArrayList<ArrayList<uint16>> ();
					SPNEPFine = new ArrayList<ArrayList<uint32>> ();

					for (int i = 0; i < NumberOfStreamPIDEntries; i += 1)
					{
						// Relative to EPMap
						input_stream.seek (Position + 2 + EPMapForOneStreamPIDStartAddress[i]);

						uint32 EPFineTableStartAddress = input_stream.read_bits_as_uint32 (32);

						RefToEPFineID.add (new ArrayList<uint32> ());
						PTSEPCoarse.add (new ArrayList<uint16> ());
						SPNEPCoarse.add (new ArrayList<uint32> ());

						for (int j = 0; j < NumberOfEPCoarseEntries[i]; j += 1)
						{
							RefToEPFineID[i].add (input_stream.read_bits_as_uint32 (18));
							PTSEPCoarse[i].add (input_stream.read_bits_as_uint16 (14));
							SPNEPCoarse[i].add (input_stream.read_bits_as_uint32 (32));
						}

						// Relative to EPMap
						input_stream.seek (Position + 2 + EPMapForOneStreamPIDStartAddress[i] + EPFineTableStartAddress);

						ReservedEPFine.add (new ArrayList<uint8> ());
						IEndPositionOffset.add (new ArrayList<uint8> ());
						PTSEPFine.add (new ArrayList<uint16> ());
						SPNEPFine.add (new ArrayList<uint32> ());

						for (int j = 0; j < NumberOfEPFineEntries[i]; j += 1)
						{
							ReservedEPFine[i].add (input_stream.read_bits_as_uint8 (1));
							IEndPositionOffset[i].add (input_stream.read_bits_as_uint8 (3));
							PTSEPFine[i].add (input_stream.read_bits_as_uint16 (11));
							SPNEPFine[i].add (input_stream.read_bits_as_uint32 (17));
						}
					}
				}

				input_stream.seek (Position + Length);
			}
			catch (IOError e)
			{
				throw new ParseError.INPUT_ERROR ("Couldn't parse CPI.");
			}
		}

//		public void write (BitOutputStream output_stream)
//		{
//		}
	}
}

