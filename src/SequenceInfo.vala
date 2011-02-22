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
	class SequenceInfo : Object
	{
		public ArrayList<uint32> SPNATCStart { get; set; }

		public ArrayList<uint8> OffsetSTCID { get; set; }

		public ArrayList<ArrayList<uint16>> PCRPID { get; set; }

		public ArrayList<ArrayList<uint32>> SPNSTCStart { get; set; }

		public ArrayList<ArrayList<uint32>> PresentationStartTime { get; set; }

		public ArrayList<ArrayList<uint32>> PresentationEndTime { get; set; }

		public SequenceInfo.from_bit_input_stream (BitInputStream input_stream) throws ParseError
		{
			try
			{
				uint32 Length = input_stream.read_bits_as_uint32 (32);

				int64 Position = input_stream.tell (); // Needed to seek

				input_stream.skip_bits (8);

				uint8 NumberOfATCSequences = input_stream.read_bits_as_uint8 (8);

				SPNATCStart = new ArrayList<uint32> ();
				OffsetSTCID = new ArrayList<uint8> ();
				PCRPID = new ArrayList<ArrayList<uint16>> ();
				SPNSTCStart = new ArrayList<ArrayList<uint32>> ();
				PresentationStartTime = new ArrayList<ArrayList<uint32>> ();
				PresentationEndTime = new ArrayList<ArrayList<uint32>> ();

				for (int i = 0; i < NumberOfATCSequences; i += 1)
				{
					SPNATCStart.add (input_stream.read_bits_as_uint32 (32));

					uint8 NumberOfSTCSequences = input_stream.read_bits_as_uint8 (8);

					OffsetSTCID.add (input_stream.read_bits_as_uint8 (8));

					PCRPID.add (new ArrayList<uint16> ());
					SPNSTCStart.add (new ArrayList<uint32> ());
					PresentationStartTime.add (new ArrayList<uint32> ());
					PresentationEndTime.add (new ArrayList<uint32> ());

					for (int j = 0; j < NumberOfSTCSequences; j += 1)
					{
						PCRPID[i].add (input_stream.read_bits_as_uint16 (16));
						SPNSTCStart[i].add (input_stream.read_bits_as_uint32 (32));
						PresentationStartTime[i].add (input_stream.read_bits_as_uint32 (32));
						PresentationEndTime[i].add (input_stream.read_bits_as_uint32 (32));
					}
				}

				input_stream.seek (Position + Length);
			}
			catch (IOError e)
			{
				throw new ParseError.INPUT_ERROR ("Couldn't parse SequenceInfo.");
			}
		}

//		public void write (BitOutputStream output_stream)
//		{
//		}
	}
}

