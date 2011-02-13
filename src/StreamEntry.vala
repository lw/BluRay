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
	class StreamEntry : Object
	{
		public uint8 StreamType { get; set; }

		public uint8 RefToSubPathID { get; set; }

		public uint8 RefToSubClipID { get; set; }

		public uint16 RefToStreamPID { get; set; }

		public StreamEntry.from_bit_input_stream (BitInputStream input_stream) throws ParseError
		{
			try
			{
				uint8 Length = input_stream.read_bits_as_uint8 (8);

				int64 Position = input_stream.tell (); // Needed to seek

				StreamType = input_stream.read_bits_as_uint8 (8);

				if (StreamType == 0x01)
				{
					RefToStreamPID = input_stream.read_bits_as_uint16 (16);
				}
				else if (StreamType == 0x02)
				{
					RefToSubPathID = input_stream.read_bits_as_uint8 (8);
					RefToSubClipID = input_stream.read_bits_as_uint8 (8);
					RefToStreamPID = input_stream.read_bits_as_uint16 (16);
				}
				else if (StreamType == 0x03)
				{
					RefToStreamPID = input_stream.read_bits_as_uint16 (16);
				}
				else if (StreamType == 0x04)
				{
					RefToSubPathID = input_stream.read_bits_as_uint8 (8);
					RefToSubClipID = input_stream.read_bits_as_uint8 (8);
					RefToStreamPID = input_stream.read_bits_as_uint16 (16);
				}

				input_stream.seek (Position + Length);
			}
			catch (IOError e)
			{
				throw new ParseError.INPUT_ERROR ("Couldn't parse StreamEntry.");
			}
		}

//		public void write (BitOutputStream output_stream)
//		{
//		}
	}
}

