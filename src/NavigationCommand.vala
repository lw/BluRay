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
	class NavigationCommand : Object
	{
		public uint8 OperandCount { get; set; }

		public uint8 CommandGroup { get; set; }

		public uint8 CommandSubGroup { get; set; }

		public uint8 ImmediateValueFlag1 { get; set; }

		public uint8 ImmediateValueFlag2 { get; set; }

		public uint8 BranchOption { get; set; }

		public uint8 CompareOption { get; set; }

		public uint8 SetOption { get; set; }

		public uint32 Operand1 { get; set; }

		public uint32 Operand2 { get; set; }

		public void read (FileReader reader)
		{
			OperandCount = reader.read_bits_as_uint8 (3);
			CommandGroup = reader.read_bits_as_uint8 (2);
			CommandSubGroup = reader.read_bits_as_uint8 (3);
			ImmediateValueFlag1 = reader.read_bits_as_uint8 (1);
			ImmediateValueFlag2 = reader.read_bits_as_uint8 (1);

			reader.skip_bits (2);

			BranchOption = reader.read_bits_as_uint8 (4);

			reader.skip_bits (4);

			CompareOption = reader.read_bits_as_uint8 (4);

			reader.skip_bits (3);

			SetOption = reader.read_bits_as_uint8 (5);
			Operand1 = reader.read_bits_as_uint32 (32);
			Operand2 = reader.read_bits_as_uint32 (32);
		}

		public void write (FileOutputStream stream)
		{
		}
	}
}

