#include <iostream>
#include <string>

extern "C" {
    // Inicjalizacja rdzenia Sanctuary
    int SanctuaryCoreInit() {
        std::cout << "[C++] Sanctuary Core Initialized successfully!" << std::endl;
        return 2026;
    }

    // Prosta operacja matematyczna
    int AddNumbers(int a, int b) {
        return a + b;
    }

    // Przetwarzanie pakietów danych dla mega węzła
    const char* process_data_packet(const char* input_json) {
        static std::string result;
        std::string data(input_json ? input_json : "");
        size_t length = data.length();
        result = "{\"status\": \"SUCCESS\", \"processed_bytes\": " + std::to_string(length) + ", \"node\": \"MegaPolandWetrVi_Core_C++\"}";
        return result.c_str();
    }
}
