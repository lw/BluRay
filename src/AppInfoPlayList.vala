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
	class AppInfoPlayList : Object
	{
		public uint8 PlaybackType { get; set; }

		public uint16 PlaybackCount { get; set; }

		public UOMaskTable UOMaskTable { get; set; }

		public uint8 RandomAccessFlag { get; set; }

		public uint8 AudioMixFlag { get; set; }

		public uint8 LosslessBypassFlag { get; set; }

		public AppInfoPlayList.from_bit_input_stream (BitInputStream input_stream) throws ParseError
		{
			try
			{
				uint32 Length = input_stream.read_bits_as_uint32 (32);

				int64 Position = input_stream.tell (); // Needed to seek

				input_stream.skip_bits (8);

				PlaybackType = input_stream.read_bits_as_uint8 (8);

				if (PlaybackType == 0x02 || PlaybackType == 0x03)
				{
					PlaybackCount = input_stream.read_bits_as_uint16 (16);
				}
				else
				{
					input_stream.skip_bits (16);
				}

				// UOMaskTable
				UOMaskTable = new BluRay.UOMaskTable.from_bit_input_stream (input_stream);

				RandomAccessFlag = input_stream.read_bits_as_uint8 (1);
				AudioMixFlag = input_stream.read_bits_as_uint8 (1);
				LosslessBypassFlag = input_stream.read_bits_as_uint8 (1);

				input_stream.skip_bits (13);

				input_stream.seek (Position + Length);
			}
			catch (ParseError e)
			{
				throw e;
			}
			catch (IOError e)
			{
				throw new ParseError.INPUT_ERROR ("Couldn't parse AppInfoPlayList.");
			}
		}

//		public void write (BitOutputStream output_stream)
//		{
//		}
	}
}

