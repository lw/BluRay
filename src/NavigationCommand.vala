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

		public NavigationCommand.from_bit_input_stream (BitInputStream input_stream) throws ParseError
		{
			try
			{
				OperandCount = input_stream.read_bits_as_uint8 (3);
				CommandGroup = input_stream.read_bits_as_uint8 (2);
				CommandSubGroup = input_stream.read_bits_as_uint8 (3);
				ImmediateValueFlag1 = input_stream.read_bits_as_uint8 (1);
				ImmediateValueFlag2 = input_stream.read_bits_as_uint8 (1);

				input_stream.skip_bits (2);

				BranchOption = input_stream.read_bits_as_uint8 (4);

				input_stream.skip_bits (4);

				CompareOption = input_stream.read_bits_as_uint8 (4);

				input_stream.skip_bits (3);

				SetOption = input_stream.read_bits_as_uint8 (5);
				Operand1 = input_stream.read_bits_as_uint32 (32);
				Operand2 = input_stream.read_bits_as_uint32 (32);
			}
			catch (IOError e)
			{
				throw new ParseError.INPUT_ERROR ("Couldn't parse NavigationCommand.");
			}
		}

//		public void write (BitOutputStream output_stream)
//		{
//		}
	}
}

