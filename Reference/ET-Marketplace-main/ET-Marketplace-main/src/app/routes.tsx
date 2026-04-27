import { createBrowserRouter } from "react-router";
import { RootLayout } from "./components/layout/RootLayout";
import { Home } from "./pages/Home";
import { Marketplace } from "./pages/Marketplace";
import { Dashboard } from "./pages/Dashboard";
import { ProjectDetails } from "./pages/ProjectDetails";

export const router = createBrowserRouter([
  {
    path: "/",
    Component: RootLayout,
    children: [
      { index: true, Component: Home },
      { path: "marketplace", Component: Marketplace },
      { path: "dashboard", Component: Dashboard },
      { path: "project/:id", Component: ProjectDetails },
    ],
  },
]);
