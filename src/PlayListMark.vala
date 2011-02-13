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

namespace BluRay
{
	class PlayListMark : Object
	{
		public uint8[] MarkType { get; set; }

		public uint16[] RefToPlayItemID { get; set; }

		public uint32[] MarkTimeStamp { get; set; }

		public uint16[] EntryESPID { get; set; }

		public uint32[] Duration { get; set; }

		public PlayListMark.from_bit_input_stream (BitInputStream input_stream) throws ParseError
		{
			try
			{
				uint32 Length = input_stream.read_bits_as_uint32 (32);

				int64 Position = input_stream.tell (); // Needed to seek

				uint16 NumberOfPlayListMarks = input_stream.read_bits_as_uint16 (16);

				MarkType = new uint8[NumberOfPlayListMarks];
				RefToPlayItemID = new uint16[NumberOfPlayListMarks];
				MarkTimeStamp = new uint32[NumberOfPlayListMarks];
				EntryESPID = new uint16[NumberOfPlayListMarks];
				Duration = new uint32[NumberOfPlayListMarks];

				for (int i = 0; i < NumberOfPlayListMarks; i += 1)
				{
					input_stream.skip_bits (8);

					MarkType[i] = input_stream.read_bits_as_uint8 (8);
					RefToPlayItemID[i] = input_stream.read_bits_as_uint16 (16);
					MarkTimeStamp[i] = input_stream.read_bits_as_uint32 (32);
					EntryESPID[i] = input_stream.read_bits_as_uint16 (16);
					Duration[i] = input_stream.read_bits_as_uint32 (32);
				}

				input_stream.seek (Position + Length);
			}
			catch (IOError e)
			{
				throw new ParseError.INPUT_ERROR ("Couldn't parse PlayListMark.");
			}
		}

//		public void write (BitOutputStream output_stream)
//		{
//		}
	}
}

