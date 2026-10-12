using System;
using System.Runtime.InteropServices;

class Program
{
    [DllImport("./libcore.so", EntryPoint = "process_data_packet", CharSet = CharSet.Ansi)]
    private static extern IntPtr process_data_packet(string inputJson);

    static void Main(string[] args)
    {
        Console.WriteLine("==================================================");
        Console.WriteLine("  Mr.Mekrix | AI & IT Sanctuary Engine v1.0       ");
        Console.WriteLine("  Ekosystem: Mega Poland Wetr'vi                  ");
        Console.WriteLine("==================================================");

        string testPayload = "{\"user\": \"Mr.Mekrix\", \"action\": \"Takeout_Analysis\"}";

        try
        {
            IntPtr ptr = process_data_packet(testPayload);
            string result = Marshal.PtrToStringAnsi(ptr);

            Console.WriteLine("\n[+] Status Silnika C++:");
            Console.WriteLine(result);
            Console.WriteLine("\n[+] Gotowość warstwy C# (.NET / AI Kernel): AKTYWNA");
            Console.WriteLine("\n#WszystkoTwoje | #JestMoje");
        }
        catch (Exception ex)
        {
            Console.WriteLine($"[-] Błąd połączenia warstw: {ex.Message}");
        }
    }
}
