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
	class ClipInfo : Object
	{
		public uint8 ClipStreamType { get; set; }

		public uint8 ApplicationType { get; set; }

		public uint8 IsCC5 { get; set; }

		public uint32 TSRecordingRate { get; set; }

		public uint32 NumberOfSourcePackets { get; set; }

		public TSTypeInfoBlock TSTypeInfoBlock { get; set; }

		public ClipInfo.from_bit_input_stream (BitInputStream input_stream) throws ParseError
		{
			try
			{
				uint32 Length = input_stream.read_bits_as_uint32 (32);

				int64 Position = input_stream.tell (); // Needed to seek

				input_stream.skip_bits (16);

				ClipStreamType = input_stream.read_bits_as_uint8 (8);
				ApplicationType = input_stream.read_bits_as_uint8 (8);

				input_stream.skip_bits (31);

				IsCC5 = input_stream.read_bits_as_uint8 (1);
				TSRecordingRate = input_stream.read_bits_as_uint32 (32);
				NumberOfSourcePackets = input_stream.read_bits_as_uint32 (32);

				input_stream.skip_bits (1024);

				// TSTypeInfoBlock
	//			TSTypeInfoBlock = new BluRay.TSTypeInfoBlock (input_stream);

				// TODO: CC5

				input_stream.seek (Position + Length);
			}
			catch (IOError e)
			{
				throw new ParseError.INPUT_ERROR ("Couldn't parse ClipInfo.");
			}
		}

//		public void write (BitOutputStream output_stream)
//		{
//		}
	}
}

