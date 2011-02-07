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
	class StreamAttributes : Object
	{
		public uint8 StreamCodingType { get; set; }

		public uint8 VideoFormat { get; set; }

		public uint8 FrameRate { get; set; }

		public uint8 AudioFormat { get; set; }

		public uint8 SampleRate { get; set; }

		public uint8 CharacterCode { get; set; }

		public string LanguageCode { get; set; default = "eng"; }

		public StreamAttributes.from_file (FileReader reader)
		{
			read (reader);
		}

		public void read (FileReader reader)
		{
			uint8 Length = reader.read_bits_as_uint8 (8);

			int64 Position = reader.tell (); // Needed to seek

			StreamCodingType = reader.read_bits_as_uint8 (8);

			switch (StreamCodingType)
			{
				case 0x02:
				case 0x1B:
				case 0xEA:
					VideoFormat = reader.read_bits_as_uint8 (4);
					FrameRate = reader.read_bits_as_uint8 (4);
					break;
				case 0x80:
				case 0x81:
				case 0x82:
				case 0x83:
				case 0x84:
				case 0x85:
				case 0x86:
				case 0xA1:
				case 0xA2:
					AudioFormat = reader.read_bits_as_uint8 (8);
					SampleRate = reader.read_bits_as_uint8 (8);
					LanguageCode = reader.read_string (3);
					break;
				case 0x90:
				case 0x91:
					LanguageCode = reader.read_string (3);
					break;
				case 0x92:
					CharacterCode = reader.read_bits_as_uint8 (8);
					LanguageCode = reader.read_string (3);
					break;
			}

			reader.seek (Position + Length);
		}

		public void write (FileOutputStream stream)
		{
		}
	}
}

