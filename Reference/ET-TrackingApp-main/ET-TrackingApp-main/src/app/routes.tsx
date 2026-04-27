import { createBrowserRouter } from "react-router";
import Layout from "./components/Layout";
import Dashboard from "./components/Dashboard";
import Marketplace from "./components/Marketplace";
import Sensors from "./components/Sensors";
import Wallet from "./components/Wallet";

export const router = createBrowserRouter([
  {
    path: "/",
    Component: Layout,
    children: [
      { index: true, Component: Dashboard },
      { path: "marketplace", Component: Marketplace },
      { path: "sensors", Component: Sensors },
      { path: "wallet", Component: Wallet },
    ],
  },
]);
