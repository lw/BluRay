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
	class ProgramInfo : Object
	{
		public ArrayList<uint32> SPNProgramSequenceStart { get; set; }

		public ArrayList<uint16> ProgramMapPID { get; set; }

		public ArrayList<ArrayList<uint16>> StreamPID { get; set; }

		public ArrayList<ArrayList<StreamCodingInfo>> StreamCodingInfo { get; set; }

		public ProgramInfo.from_bit_input_stream (BitInputStream input_stream) throws ParseError
		{
			try
			{
				uint32 Length = input_stream.read_bits_as_uint32 (32);

				int64 Position = input_stream.tell (); // Needed to seek

				input_stream.skip_bits (8);

				uint8 NumberOfPrograms = input_stream.read_bits_as_uint8 (8);

				SPNProgramSequenceStart = new ArrayList<uint32> ();
				ProgramMapPID = new ArrayList<uint16> ();
				StreamPID = new ArrayList<ArrayList<uint16>> ();
				StreamCodingInfo = new ArrayList<ArrayList<StreamCodingInfo>> ();

				for (int i = 0; i < NumberOfPrograms; i += 1)
				{
					SPNProgramSequenceStart.add (input_stream.read_bits_as_uint32 (32));
					ProgramMapPID.add (input_stream.read_bits_as_uint16 (16));

					uint8 NumberOfStreamsInPS = input_stream.read_bits_as_uint8 (8);

					input_stream.skip_bits (8);

					StreamPID.add (new ArrayList<uint16> ());
					StreamCodingInfo.add (new ArrayList<StreamCodingInfo> ());

					for (int j = 0; j < NumberOfStreamsInPS; j += 1)
					{
						StreamPID[i].add (input_stream.read_bits_as_uint16 (16));
						StreamCodingInfo[i].add (new BluRay.StreamCodingInfo.from_bit_input_stream (input_stream));
					}
				}

				input_stream.seek (Position + Length);
			}
			catch (ParseError e)
			{
				throw e;
			}
			catch (IOError e)
			{
				throw new ParseError.INPUT_ERROR ("Couldn't parse ProgramInfo.");
			}
		}

//		public void write (BitOutputStream output_stream)
//		{
//		}
	}
}

