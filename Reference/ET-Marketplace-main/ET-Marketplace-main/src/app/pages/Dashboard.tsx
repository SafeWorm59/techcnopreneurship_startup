import { useRole } from "../context/RoleContext";
import { TreePine, Wallet, Activity, ArrowUpRight, CheckCircle2, DollarSign, CloudRain, Building2, Globe2, ShieldCheck, Download } from "lucide-react";
import { LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, AreaChart, Area, BarChart, Bar } from 'recharts';
import { ImageWithFallback } from "../components/figma/ImageWithFallback";

const MOCK_DASHBOARD_DATA = {
  landowner: {
    name: "Datu Salise",
    role: "Carbon Guardian",
    location: "Impasugong, Bukidnon",
    totalEarnings: "$2,450.00",
    activeSensors: 14,
    co2Absorbed: "85 Tons",
    recentTransactions: [
      { id: "tx-1029", date: "2026-04-01", amount: "+$450.00", buyer: "Global Airlines Inc." },
      { id: "tx-1028", date: "2026-03-28", amount: "+$120.00", buyer: "Tech Corp Logistics" },
      { id: "tx-1027", date: "2026-03-15", amount: "+$880.00", buyer: "EcoFund Global" },
    ],
    chartData: [
      { name: 'Jan', co2: 60, earnings: 400 },
      { name: 'Feb', co2: 65, earnings: 450 },
      { name: 'Mar', co2: 70, earnings: 800 },
      { name: 'Apr', co2: 85, earnings: 800 },
    ]
  },
  corporate: {
    name: "Global Airlines Inc.",
    role: "Corporate Buyer",
    location: "New York, USA",
    totalInvested: "$12,450.00",
    activeProjects: 3,
    co2Offset: "850 Tons",
    recentPurchases: [
      { id: "tx-1029", date: "2026-04-01", amount: "-$450.00", project: "Mt. Kitanglad Buffer Zone" },
      { id: "tx-1015", date: "2026-02-14", amount: "-$2,100.00", project: "Kalatungan Reforestation" },
      { id: "tx-0992", date: "2025-11-30", amount: "-$9,900.00", project: "Manolo Fortich Canopy" },
    ],
    chartData: [
      { name: 'Jan', offset: 120, target: 150 },
      { name: 'Feb', offset: 180, target: 150 },
      { name: 'Mar', offset: 250, target: 200 },
      { name: 'Apr', offset: 300, target: 200 },
    ]
  }
};

export function Dashboard() {
  const { role } = useRole();

  if (role === "corporate") {
    return <CorporateDashboard />;
  }

  return <LandownerDashboard />;
}

function CorporateDashboard() {
  return (
    <div className="w-full min-h-screen bg-[#EBD5AB] text-[#1B211A] pt-20">
      <div className="bg-[#1B211A] border-b border-[#628141]/30">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
          <div className="flex flex-col md:flex-row justify-between items-start md:items-center gap-6">
            <div className="flex items-center gap-6">
              <div className="relative">
                <div className="w-20 h-20 rounded-2xl bg-[#EBD5AB] flex items-center justify-center shadow-xl shadow-[#1B211A]/20 overflow-hidden border-2 border-[#8BAE66]">
                  <Building2 className="w-10 h-10 text-[#1B211A]" />
                </div>
                <div className="absolute -bottom-2 -right-2 bg-[#628141] p-1.5 rounded-full border border-[#1B211A]">
                  <ShieldCheck className="w-5 h-5 text-[#EBD5AB]" />
                </div>
              </div>
              <div>
                <h1 className="text-3xl font-extrabold text-[#EBD5AB] tracking-tight">
                  Welcome back, {MOCK_DASHBOARD_DATA.corporate.name}
                </h1>
                <p className="text-[#8BAE66] font-medium flex items-center gap-2 mt-1">
                  <Globe2 className="w-4 h-4" />
                  {MOCK_DASHBOARD_DATA.corporate.role} • ESG Portfolio
                </p>
              </div>
            </div>
            
            <div className="flex gap-4 w-full md:w-auto">
              <button 
                className="flex-1 md:flex-none px-6 py-3 bg-[#628141]/20 text-[#8BAE66] border border-[#628141]/30 rounded-xl font-bold hover:bg-[#628141]/30 transition-colors flex items-center justify-center gap-2"
              >
                <Download className="w-5 h-5" />
                ESG Report
              </button>
              <button 
                className="flex-1 md:flex-none px-6 py-3 bg-[#EBD5AB] text-[#1B211A] rounded-xl font-extrabold shadow-lg hover:bg-white transition-colors flex items-center justify-center gap-2"
              >
                <Wallet className="w-5 h-5" />
                Add Funds
              </button>
            </div>
          </div>
        </div>
      </div>

      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-12">
          {[
            { label: "Total Invested", value: MOCK_DASHBOARD_DATA.corporate.totalInvested, icon: <DollarSign className="w-6 h-6 text-[#EBD5AB]" />, color: "bg-[#1B211A]", text: "text-[#EBD5AB]" },
            { label: "Active Projects Supported", value: MOCK_DASHBOARD_DATA.corporate.activeProjects.toString(), icon: <Globe2 className="w-6 h-6 text-[#1B211A]" />, color: "bg-white", text: "text-[#1B211A]", border: "border border-[#628141]/20" },
            { label: "Verified CO2 Offset", value: MOCK_DASHBOARD_DATA.corporate.co2Offset, icon: <TreePine className="w-6 h-6 text-[#EBD5AB]" />, color: "bg-[#628141]", text: "text-[#EBD5AB]" },
          ].map((stat, idx) => (
            <div key={idx} className={`${stat.color} rounded-3xl p-8 shadow-xl hover:-translate-y-1 transition-transform ${stat.border || ''}`}>
              <div className="flex justify-between items-start mb-4">
                <div className={`p-3 rounded-2xl bg-black/10 backdrop-blur-sm ${idx === 1 ? 'bg-[#628141]/10' : ''}`}>
                  {stat.icon}
                </div>
                <ArrowUpRight className={`w-5 h-5 ${stat.text} opacity-50`} />
              </div>
              <p className={`${stat.text} opacity-70 text-sm font-bold uppercase tracking-wider mb-1`}>{stat.label}</p>
              <h3 className={`text-4xl font-extrabold ${stat.text}`}>{stat.value}</h3>
            </div>
          ))}
        </div>

        <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
          <div className="lg:col-span-2 bg-white rounded-3xl p-8 shadow-xl shadow-[#1B211A]/5 border border-[#628141]/10">
            <div className="flex justify-between items-center mb-8">
              <div>
                <h3 className="text-xl font-bold text-[#1B211A]">Carbon Offset Progress vs Target</h3>
                <p className="text-sm font-medium text-[#1B211A]/60">Year to Date Overview (Tons CO2)</p>
              </div>
              <select className="bg-[#1B211A]/5 border border-[#628141]/20 text-[#1B211A] rounded-xl px-4 py-2 font-bold text-sm outline-none focus:ring-2 focus:ring-[#628141]">
                <option>2026</option>
                <option>2025</option>
              </select>
            </div>
            
            <div className="h-80 w-full">
              <ResponsiveContainer width="100%" height="100%">
                <BarChart data={MOCK_DASHBOARD_DATA.corporate.chartData} margin={{ top: 10, right: 30, left: 0, bottom: 0 }}>
                  <CartesianGrid key="grid" strokeDasharray="3 3" vertical={false} stroke="#EBD5AB" />
                  <XAxis key="xaxis" dataKey="name" axisLine={false} tickLine={false} tick={{ fill: '#1B211A', opacity: 0.5, fontWeight: 'bold' }} />
                  <YAxis key="yaxis" axisLine={false} tickLine={false} tick={{ fill: '#1B211A', opacity: 0.5, fontWeight: 'bold' }} />
                  <Tooltip 
                    key="tooltip"
                    contentStyle={{ backgroundColor: '#1B211A', borderRadius: '12px', border: 'none', color: '#EBD5AB', fontWeight: 'bold' }}
                    itemStyle={{ color: '#8BAE66' }}
                    cursor={{fill: '#EBD5AB', opacity: 0.4}}
                  />
                  <Bar key="bar1" dataKey="target" fill="#EBD5AB" radius={[4, 4, 0, 0]} />
                  <Bar key="bar2" dataKey="offset" fill="#628141" radius={[4, 4, 0, 0]} />
                </BarChart>
              </ResponsiveContainer>
            </div>
          </div>

          <div className="bg-[#1B211A] rounded-3xl p-8 shadow-xl border border-[#628141]/20 flex flex-col">
            <h3 className="text-xl font-bold text-[#EBD5AB] mb-1">Recent Purchases</h3>
            <p className="text-sm font-medium text-[#8BAE66] mb-8">Credits added to your portfolio</p>
            
            <div className="space-y-6 flex-1">
              {MOCK_DASHBOARD_DATA.corporate.recentPurchases.map((tx, idx) => (
                <div key={idx} className="flex items-center justify-between pb-6 border-b border-[#628141]/20 last:border-0 last:pb-0">
                  <div className="flex items-center gap-4">
                    <div className="w-12 h-12 rounded-xl bg-[#628141]/20 flex items-center justify-center border border-[#628141]/30">
                      <TreePine className="w-6 h-6 text-[#8BAE66]" />
                    </div>
                    <div>
                      <p className="font-bold text-[#EBD5AB]">{tx.project}</p>
                      <p className="text-xs font-medium text-[#8BAE66]">{tx.date} • {tx.id}</p>
                    </div>
                  </div>
                  <span className="font-extrabold text-[#EBD5AB]">{tx.amount}</span>
                </div>
              ))}
            </div>
            
            <button className="w-full mt-6 py-4 rounded-xl border-2 border-[#628141]/30 text-[#8BAE66] font-bold hover:bg-[#628141]/10 transition-colors">
              View All Certificates
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}

function LandownerDashboard() {
  return (
    <div className="w-full min-h-screen bg-[#EBD5AB] text-[#1B211A] pt-20">
      
      {/* Dashboard Header */}
      <div className="bg-[#1B211A] border-b border-[#628141]/30">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
          <div className="flex flex-col md:flex-row justify-between items-start md:items-center gap-6">
            <div className="flex items-center gap-6">
              <div className="relative">
                <div className="w-20 h-20 rounded-2xl bg-[#628141] flex items-center justify-center shadow-xl shadow-[#1B211A]/20 overflow-hidden border-2 border-[#8BAE66]">
                  <ImageWithFallback 
                    src="https://images.unsplash.com/photo-1763909976168-06645db32f6a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHx0ZWNobm9sb2d5JTIwc2Vuc29yJTIwbmF0dXJlfGVufDF8fHx8MTc3NTEwMDYwMXww&ixlib=rb-4.1.0&q=80&w=1080&utm_source=figma&utm_medium=referral"
                    alt="Profile"
                    className="w-full h-full object-cover"
                  />
                </div>
                <div className="absolute -bottom-2 -right-2 bg-[#EBD5AB] p-1.5 rounded-full border border-[#1B211A]">
                  <CheckCircle2 className="w-5 h-5 text-[#628141]" />
                </div>
              </div>
              <div>
                <h1 className="text-3xl font-extrabold text-[#EBD5AB] tracking-tight">
                  Welcome back, {MOCK_DASHBOARD_DATA.landowner.name}
                </h1>
                <p className="text-[#8BAE66] font-medium flex items-center gap-2 mt-1">
                  <TreePine className="w-4 h-4" />
                  {MOCK_DASHBOARD_DATA.landowner.role} • {MOCK_DASHBOARD_DATA.landowner.location}
                </p>
              </div>
            </div>
            
            <div className="flex gap-4 w-full md:w-auto">
              <button 
                className="flex-1 md:flex-none px-6 py-3 bg-[#628141]/20 text-[#8BAE66] border border-[#628141]/30 rounded-xl font-bold hover:bg-[#628141]/30 transition-colors flex items-center justify-center gap-2"
              >
                <CloudRain className="w-5 h-5" />
                Sensor Report
              </button>
              <button 
                className="flex-1 md:flex-none px-6 py-3 bg-[#EBD5AB] text-[#1B211A] rounded-xl font-extrabold shadow-lg hover:bg-white transition-colors flex items-center justify-center gap-2"
              >
                <Wallet className="w-5 h-5" />
                Withdraw Funds
              </button>
            </div>
          </div>
        </div>
      </div>

      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
        {/* Stats Grid */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-12">
          {[
            { label: "Total Earnings", value: MOCK_DASHBOARD_DATA.landowner.totalEarnings, icon: <DollarSign className="w-6 h-6 text-[#EBD5AB]" />, color: "bg-[#1B211A]", text: "text-[#EBD5AB]" },
            { label: "Active EchoTrace Sensors", value: MOCK_DASHBOARD_DATA.landowner.activeSensors.toString(), icon: <Activity className="w-6 h-6 text-[#1B211A]" />, color: "bg-white", text: "text-[#1B211A]", border: "border border-[#628141]/20" },
            { label: "Verified CO2 Absorbed", value: MOCK_DASHBOARD_DATA.landowner.co2Absorbed, icon: <TreePine className="w-6 h-6 text-[#EBD5AB]" />, color: "bg-[#628141]", text: "text-[#EBD5AB]" },
          ].map((stat, idx) => (
            <div key={idx} className={`${stat.color} rounded-3xl p-8 shadow-xl hover:-translate-y-1 transition-transform ${stat.border || ''}`}>
              <div className="flex justify-between items-start mb-4">
                <div className={`p-3 rounded-2xl bg-black/10 backdrop-blur-sm ${idx === 1 ? 'bg-[#628141]/10' : ''}`}>
                  {stat.icon}
                </div>
                <ArrowUpRight className={`w-5 h-5 ${stat.text} opacity-50`} />
              </div>
              <p className={`${stat.text} opacity-70 text-sm font-bold uppercase tracking-wider mb-1`}>{stat.label}</p>
              <h3 className={`text-4xl font-extrabold ${stat.text}`}>{stat.value}</h3>
            </div>
          ))}
        </div>

        <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
          {/* Main Chart */}
          <div className="lg:col-span-2 bg-white rounded-3xl p-8 shadow-xl shadow-[#1B211A]/5 border border-[#628141]/10">
            <div className="flex justify-between items-center mb-8">
              <div>
                <h3 className="text-xl font-bold text-[#1B211A]">Carbon Absorption vs Earnings</h3>
                <p className="text-sm font-medium text-[#1B211A]/60">Year to Date Overview</p>
              </div>
              <select className="bg-[#1B211A]/5 border border-[#628141]/20 text-[#1B211A] rounded-xl px-4 py-2 font-bold text-sm outline-none focus:ring-2 focus:ring-[#628141]">
                <option>2026</option>
                <option>2025</option>
              </select>
            </div>
            
            <div className="h-80 w-full">
              <ResponsiveContainer width="100%" height="100%">
                <AreaChart data={MOCK_DASHBOARD_DATA.landowner.chartData} margin={{ top: 10, right: 30, left: 0, bottom: 0 }}>
                  <defs key="defs">
                    <linearGradient id="colorEarnings" x1="0" y1="0" x2="0" y2="1">
                      <stop key="stop1" offset="5%" stopColor="#628141" stopOpacity={0.8}/>
                      <stop key="stop2" offset="95%" stopColor="#628141" stopOpacity={0}/>
                    </linearGradient>
                  </defs>
                  <CartesianGrid key="grid" strokeDasharray="3 3" vertical={false} stroke="#EBD5AB" />
                  <XAxis key="xaxis" dataKey="name" axisLine={false} tickLine={false} tick={{ fill: '#1B211A', opacity: 0.5, fontWeight: 'bold' }} />
                  <YAxis key="yaxis" axisLine={false} tickLine={false} tick={{ fill: '#1B211A', opacity: 0.5, fontWeight: 'bold' }} />
                  <Tooltip 
                    key="tooltip"
                    contentStyle={{ backgroundColor: '#1B211A', borderRadius: '12px', border: 'none', color: '#EBD5AB', fontWeight: 'bold' }}
                    itemStyle={{ color: '#8BAE66' }}
                  />
                  <Area key="area" type="monotone" dataKey="earnings" stroke="#628141" strokeWidth={3} fillOpacity={1} fill="url(#colorEarnings)" />
                </AreaChart>
              </ResponsiveContainer>
            </div>
          </div>

          {/* Recent Transactions */}
          <div className="bg-[#1B211A] rounded-3xl p-8 shadow-xl border border-[#628141]/20 flex flex-col">
            <h3 className="text-xl font-bold text-[#EBD5AB] mb-1">Recent Sales</h3>
            <p className="text-sm font-medium text-[#8BAE66] mb-8">Credits purchased by global buyers</p>
            
            <div className="space-y-6 flex-1">
              {MOCK_DASHBOARD_DATA.landowner.recentTransactions.map((tx, idx) => (
                <div key={idx} className="flex items-center justify-between pb-6 border-b border-[#628141]/20 last:border-0 last:pb-0">
                  <div className="flex items-center gap-4">
                    <div className="w-12 h-12 rounded-xl bg-[#628141]/20 flex items-center justify-center border border-[#628141]/30">
                      <DollarSign className="w-6 h-6 text-[#8BAE66]" />
                    </div>
                    <div>
                      <p className="font-bold text-[#EBD5AB]">{tx.buyer}</p>
                      <p className="text-xs font-medium text-[#8BAE66]">{tx.date} • {tx.id}</p>
                    </div>
                  </div>
                  <span className="font-extrabold text-[#8BAE66]">{tx.amount}</span>
                </div>
              ))}
            </div>
            
            <button className="w-full mt-6 py-4 rounded-xl border-2 border-[#628141]/30 text-[#8BAE66] font-bold hover:bg-[#628141]/10 transition-colors">
              View All Transactions
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}
