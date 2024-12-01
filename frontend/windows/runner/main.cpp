#include <flutter/dart_project.h>
#include <flutter/flutter_view_controller.h>
#include <windows.h>

#include "flutter_window.h"
#include "utils.h"

int APIENTRY wWinMain(_In_ HINSTANCE instance, _In_opt_ HINSTANCE prev,
                      _In_ wchar_t *command_line, _In_ int show_command) {
  // Attach to console when present (e.g., 'flutter run') or create a
  // new console when running with a debugger.
  if (!::AttachConsole(ATTACH_PARENT_PROCESS) && ::IsDebuggerPresent()) {
    CreateAndAttachConsole();
  }

  // Initialize COM, so that it is available for use in the library and/or
  // plugins.
  ::CoInitializeEx(nullptr, COINIT_APARTMENTTHREADED);

  flutter::DartProject project(L"data");

  std::vector<std::string> command_line_arguments =
      GetCommandLineArguments();

  project.set_dart_entrypoint_arguments(std::move(command_line_arguments));

  FlutterWindow window(project);

  // Obtén el tamaño de la pantalla principal
  HMONITOR monitor = MonitorFromWindow(nullptr, MONITOR_DEFAULTTOPRIMARY);
  MONITORINFO monitor_info = {sizeof(monitor_info)};
  GetMonitorInfo(monitor, &monitor_info);

  // Configurar la ventana para que ocupe toda la pantalla
  Win32Window::Point origin(0, 0);
  Win32Window::Size size(
      monitor_info.rcMonitor.right - monitor_info.rcMonitor.left,
      monitor_info.rcMonitor.bottom - monitor_info.rcMonitor.top);

  if (!window.Create(L"frontend", origin, size)) {
    return EXIT_FAILURE;
  }

  // Eliminar bordes y hacer la ventana en pantalla completa
  SetWindowLong(window.GetHandle(), GWL_STYLE, WS_POPUP | WS_VISIBLE);
  ShowWindow(window.GetHandle(), SW_MAXIMIZE);

  window.SetQuitOnClose(true);

  ::MSG msg;
  while (::GetMessage(&msg, nullptr, 0, 0)) {
    ::TranslateMessage(&msg);
    ::DispatchMessage(&msg);
  }

  ::CoUninitialize();
  return EXIT_SUCCESS;
}
