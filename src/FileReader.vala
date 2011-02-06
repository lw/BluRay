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
	class FileReader
	{
		private FileInputStream stream;

		private uint8[] byte;

		private uint8 position;

		public FileReader (FileInputStream base_stream)
		{
			stream = base_stream;
			byte += 0;
			position = 0;
		}

		public uint8 read_bits_as_uint8 (int size) throws IOError
		{
			uint8 result = 0;

			while (position > 0x00 && size > 0)
			{
				result *= 2;
				result += byte[0] / position;
				byte[0] %= position;
				position /= 2;
				size -= 1;
			}

			while (size >= 8)
			{
				result *= (uint8) 256;
				stream.read (byte);
				result += byte[0];
				size -= 8;
			}

			if (size > 0)
			{
				stream.read (byte);
				position = 0x80;
			}

			while (position > 0x00 && size > 0)
			{
				result *= 2;
				result += byte[0] / position;
				byte[0] %= position;
				position /= 2;
				size -= 1;
			}

			return result;
		}

		public uint16 read_bits_as_uint16 (int size) throws IOError
		{
			uint16 result = 0;

			while (position > 0x00 && size > 0)
			{
				result *= 2;
				result += byte[0] / position;
				byte[0] %= position;
				position /= 2;
				size -= 1;
			}

			while (size >= 8)
			{
				result *= (uint8) 256;
				stream.read (byte);
				result += byte[0];
				size -= 8;
			}

			if (size > 0)
			{
				stream.read (byte);
				position = 0x80;
			}

			while (position > 0x00 && size > 0)
			{
				result *= 2;
				result += byte[0] / position;
				byte[0] %= position;
				position /= 2;
				size -= 1;
			}

			return result;
		}

		public uint32 read_bits_as_uint32 (int size) throws IOError
		{
			uint32 result = 0;

			while (position > 0x00 && size > 0)
			{
				result *= 2;
				result += byte[0] / position;
				byte[0] %= position;
				position /= 2;
				size -= 1;
			}

			while (size >= 8)
			{
				result *= (uint8) 256;
				stream.read (byte);
				result += byte[0];
				size -= 8;
			}

			if (size > 0)
			{
				stream.read (byte);
				position = 0x80;
			}

			while (position > 0x00 && size > 0)
			{
				result *= 2;
				result += byte[0] / position;
				byte[0] %= position;
				position /= 2;
				size -= 1;
			}

			return result;
		}

		public uint64 read_bits_as_uint64 (int size) throws IOError
		{
			uint64 result = 0;

			while (position > 0x00 && size > 0)
			{
				result *= 2;
				result += byte[0] / position;
				byte[0] %= position;
				position /= 2;
				size -= 1;
			}

			while (size >= 8)
			{
				result *= (uint8) 256;
				stream.read (byte);
				result += byte[0];
				size -= 8;
			}

			if (size > 0)
			{
				stream.read (byte);
				position = 0x80;
			}

			while (position > 0x00 && size > 0)
			{
				result *= 2;
				result += byte[0] / position;
				byte[0] %= position;
				position /= 2;
				size -= 1;
			}

			return result;
		}

		public uint8[] read_bytes (int size)
		{
			uint8[] result = new uint8[size];

			if (position == 0x00)
			{
				stream.read (result);
			}
			else
			{
				for (int i = 0; i < size; i += 1)
				{
					result[i] = read_bits_as_uint8 (8);
				}
			}

			return result;
		}

		public string read_string (int size)
		{
			return (string) read_bytes (size);
		}

		public void skip_bits (int size)
		{
			while (position > 0x00 && size > 0)
			{
				byte[0] %= position;
				position /= 2;
				size -= 1;
			}

			stream.skip (size / 8);
			size %= 8;

			if (size > 0)
			{
				stream.read (byte);
				position = 0x80;
			}

			while (position > 0x00 && size > 0)
			{
				byte[0] %= position;
				position /= 2;
				size -= 1;
			}
		}

		public void skip_bytes (int size)
		{
			if (position == 0x00)
			{
				stream.skip (size);
			}
			else
			{
				skip_bits (size * 8);
			}
		}

		public int64 tell ()
		{
			return stream.tell ();
		}

		public void seek (int64 size)
		{
			stream.seek (size, SeekType.SET);
		}
	}
}

