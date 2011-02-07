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
	class PlayItem : Object
	{
		public string ClipInformationFileName { get; set; default = "00000"; }

		public string ClipCodecIdentifier { get; set; default = "M2TS"; }

		public uint8 IsMultiAngle { get; set; }

		public uint8 ConnectionCondition { get; set; }

		public uint8 RefToSTCID { get; set; }

		public uint32 INTime { get; set; }

		public uint32 OUTTime { get; set; }

		public UOMaskTable UOMaskTable { get; set; default = new BluRay.UOMaskTable (); }

		public uint8 PlayItemRandomAccessFlag { get; set; }

		public uint8 StillMode { get; set; }

		public uint16 StillTime { get; set; }

		public STNTable STNTable { get; set; default = new BluRay.STNTable (); }

		public PlayItem.from_file (FileReader reader)
		{
			read (reader);
		}

		public void read (FileReader reader)
		{
			uint16 Length = reader.read_bits_as_uint16 (16);

			int64 Position = reader.tell (); // Needed to seek

			ClipInformationFileName = reader.read_string (5);
			ClipCodecIdentifier = reader.read_string (4);

			reader.skip_bits (11);

			IsMultiAngle = reader.read_bits_as_uint8 (1);
			ConnectionCondition = reader.read_bits_as_uint8 (4);
			RefToSTCID = reader.read_bits_as_uint8 (8);
			INTime = reader.read_bits_as_uint32 (32);
			OUTTime = reader.read_bits_as_uint32 (32);

			// UOMaskTable
			UOMaskTable.read (reader);

			PlayItemRandomAccessFlag = reader.read_bits_as_uint8 (1);

			reader.skip_bits (7);

			StillMode = reader.read_bits_as_uint8 (8);

			if (StillMode == 0x01)
			{
				StillTime = reader.read_bits_as_uint8 (16);
			}
			else
			{
				reader.skip_bits (16);
			}

			// TODO: MultiAngle

			// STNTable
			STNTable.read (reader);

			reader.seek (Position + Length);
		}

		public void write (FileOutputStream stream)
		{
		}
	}
}

