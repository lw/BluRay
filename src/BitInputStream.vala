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
	class BitInputStream
	{
		private FileInputStream stream;

		private uint8[] byte;

		private uint8 position;

		public BitInputStream (FileInputStream base_stream)
		{
			stream = base_stream;
			byte += 0;
			position = 0;
		}

		public uint8 read_bits_as_uint8 (uint32 size) throws IOError
		{
			try
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
					result <<= 8;
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
			catch (IOError e)
			{
				throw new IOError.FAILED ("Couldn't read bits.");
			}
		}

		public uint16 read_bits_as_uint16 (uint32 size) throws IOError
		{
			try
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
					result <<= 8;
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
			catch (IOError e)
			{
				throw new IOError.FAILED ("Couldn't read bits.");
			}
		}

		public uint32 read_bits_as_uint32 (uint32 size) throws IOError
		{
			try
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
					result <<= 8;
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
			catch (IOError e)
			{
				throw new IOError.FAILED ("Couldn't read bits.");
			}
		}

		public uint64 read_bits_as_uint64 (uint32 size) throws IOError
		{
			try
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
					result <<= 8;
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
			catch (IOError e)
			{
				throw new IOError.FAILED ("Couldn't read bits.");
			}
		}

		public uint8[] read_bytes (uint32 size) throws IOError
		{
			try
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
			catch (IOError e)
			{
				throw new IOError.FAILED ("Couldn't read bytes.");
			}
		}

		public string read_string (uint32 size) throws IOError
		{
			try
			{
				return (string) read_bytes (size);
			}
			catch (IOError e)
			{
				throw new IOError.FAILED ("Couldn't read string.");
			}
		}

		public void skip_bits (uint32 size) throws IOError
		{
			try
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
			catch (IOError e)
			{
				throw new IOError.FAILED ("Couldn't skip.");
			}
		}

		public void skip_bytes (uint32 size) throws IOError
		{
			try
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
			catch (IOError e)
			{
				throw new IOError.FAILED ("Couldn't skip.");
			}
		}

		public int64 tell ()
		{
			return stream.tell ();
		}

		public void seek (int64 size) throws IOError
		{
			try
			{
				stream.seek (size, SeekType.SET);
			}
			catch (Error e)
			{
				throw new IOError.FAILED ("Couldn't seek.");
			}
		}
	}
}

