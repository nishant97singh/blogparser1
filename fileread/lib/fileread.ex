defmodule Fileread do
  def by_line(path) do ##### path= where the actual blog is stored
      file = File.open!("D:/elixirproj/fileread/pqr.txt", [:write, :utf8]) ##### path of file where tile will be written
      line=File.stream!(path)
      stream = Stream.map(line,&String.trim_trailing/1)
      stream = Enum.to_list(stream)
      u = Enum.find_index(stream, fn x -> x == "READMORE" end)
      v = length(stream)
      stream1 = Enum.slice(stream, 0, u)
      for s <- stream1 do
        if s =~ ":" do
          arr = String.split(s, ":")
          key = Enum.at(arr, 0)
          if s =~ "\"" do
            v =  String.length(Enum.at(arr, 1))-3
            value = String.slice(Enum.at(arr, 1), 2..v)
            string_to_file = key <> ":" <> value <> "\n"
            IO.binwrite(file, string_to_file)
          else
            value = Enum.at(arr, 1)
            string_to_file = key <> ":" <> value <> "\n"
            IO.binwrite(file, string_to_file)
          end
        else
          if not(s == "" or s =="---" or s == nil) do
            string_to_file = "short-content" <> ":" <> s <> "\n"
            IO.binwrite(file, string_to_file)
          end
        end
      end

      stream2 = Enum.slice(stream, u+1, v)

      st = List.to_string(stream2)

      string_to_file = "content" <> ":" <> st
      IO.binwrite(file, string_to_file)
  end
end
