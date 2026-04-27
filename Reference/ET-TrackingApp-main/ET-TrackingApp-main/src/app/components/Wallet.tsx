import { useState } from "react";
import { Wallet as WalletIcon, ArrowDownRight, ArrowUpRight, History, Download, CreditCard, PiggyBank, Percent, Briefcase, CheckCircle } from "lucide-react";
import { motion } from "motion/react";
import { useRole } from "./RoleContext";

const transactions = [
  { id: "TXN-001", type: "credit", amount: 125.50, date: "Today, 10:24 AM", status: "Completed", partner: "Airlines Inc." },
  { id: "TXN-002", type: "debit", amount: 45.00, date: "Yesterday, 2:15 PM", status: "Withdrawn", partner: "Bank Transfer" },
  { id: "TXN-003", type: "credit", amount: 84.20, date: "Oct 12, 09:00 AM", status: "Completed", partner: "Global Logistics" },
  { id: "TXN-004", type: "credit", amount: 210.00, date: "Oct 05, 11:30 AM", status: "Completed", partner: "Tech Corp" },
];

const verifierTransactions = [
  { id: "COM-001", type: "credit", amount: 15.50, date: "Today, 11:15 AM", status: "Received", partner: "Juan Dela Cruz - Plot 3" },
  { id: "COM-002", type: "debit", amount: 120.00, date: "Yesterday, 4:00 PM", status: "Withdrawn", partner: "BPI Checking" },
  { id: "COM-003", type: "credit", amount: 24.20, date: "Oct 12, 10:50 AM", status: "Received", partner: "Maria Santos - Plot 1" },
];

export default function Wallet() {
  const [activeTab, setActiveTab] = useState("all");
  const { role } = useRole();

  if (role === "VERIFIER") {
    return (
      <div className="flex flex-col min-h-full p-4 space-y-6 pt-8 pb-24 bg-[#1B211A]">
        <header className="flex justify-between items-center mb-2">
          <h1 className="text-2xl font-bold tracking-tight text-[#EBD5AB]">Commission Wallet</h1>
          <button className="p-2 bg-[#2A3329] rounded-full text-[#8BAE66] hover:bg-[#628141] hover:text-[#1B211A] transition-colors shadow-md border border-[#628141]/30">
            <History size={20} />
          </button>
        </header>

        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          className="bg-gradient-to-br from-[#2A3329] to-[#1B211A] rounded-3xl p-6 shadow-xl relative overflow-hidden text-[#EBD5AB] border border-[#8BAE66]/40"
        >
          <div className="absolute -right-10 -top-10 opacity-10 text-[#8BAE66]">
            <Briefcase size={180} />
          </div>
          
          <div className="flex justify-between items-start mb-6">
            <div className="flex items-center space-x-2 bg-[#628141]/20 px-3 py-1.5 rounded-full backdrop-blur-sm border border-[#628141]/30 shadow-inner">
              <Percent size={14} className="text-[#8BAE66]" />
              <span className="text-[#8BAE66] text-xs font-bold uppercase tracking-wider">Unpaid Commissions</span>
            </div>
          </div>
          
          <div className="flex items-baseline space-x-2">
            <span className="text-[#8BAE66] text-2xl font-bold opacity-80">₱</span>
            <span className="text-5xl font-black text-[#EBD5AB] tracking-tighter drop-shadow-sm">1,245</span>
            <span className="text-[#EBD5AB] font-bold opacity-70">.50</span>
          </div>
          
          <div className="mt-8 flex space-x-3 relative z-10">
            <button className="flex-1 bg-[#8BAE66] text-[#1B211A] py-3 rounded-2xl font-bold flex items-center justify-center hover:bg-[#628141] transition-colors shadow-md border border-[#8BAE66]/50">
              <ArrowUpRight size={18} className="mr-2" /> Payout to Bank
            </button>
          </div>
        </motion.div>

        <div className="grid grid-cols-2 gap-4">
          <div className="bg-[#2A3329] p-4 rounded-2xl border border-[#628141]/30 flex items-center space-x-3 shadow-md group hover:border-[#8BAE66]/50 transition-colors">
            <div className="w-10 h-10 rounded-full bg-[#8BAE66]/10 flex items-center justify-center text-[#8BAE66] shadow-inner group-hover:bg-[#8BAE66]/20 transition-colors">
              <CheckCircle size={20} />
            </div>
            <div>
              <p className="text-xs text-[#EBD5AB]/60 font-medium">Plots Verified</p>
              <p className="text-lg font-bold text-[#EBD5AB]">143</p>
            </div>
          </div>
          <div className="bg-[#2A3329] p-4 rounded-2xl border border-[#628141]/30 flex items-center space-x-3 shadow-md group hover:border-[#8BAE66]/50 transition-colors">
            <div className="w-10 h-10 rounded-full bg-[#EBD5AB]/10 flex items-center justify-center text-[#EBD5AB] shadow-inner group-hover:bg-[#EBD5AB]/20 transition-colors">
              <Briefcase size={20} />
            </div>
            <div>
              <p className="text-xs text-[#EBD5AB]/60 font-medium">Total Earned</p>
              <p className="text-lg font-bold text-[#EBD5AB]">₱12,500</p>
            </div>
          </div>
        </div>

        <div className="mt-6">
          <div className="flex justify-between items-center mb-4">
            <h3 className="text-lg font-bold text-[#EBD5AB]">Commission History</h3>
            <button className="text-sm text-[#8BAE66] font-semibold hover:underline">See All</button>
          </div>

          <div className="space-y-3">
            {verifierTransactions.map((txn, index) => (
              <motion.div
                key={txn.id}
                initial={{ opacity: 0, y: 10 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: 0.1 + index * 0.1 }}
                className="bg-[#2A3329]/50 p-4 rounded-2xl border border-[#628141]/20 flex items-center justify-between shadow-sm hover:bg-[#2A3329] transition-colors group cursor-pointer"
              >
                <div className="flex items-center space-x-3">
                  <div className={`w-10 h-10 rounded-full flex items-center justify-center shadow-inner ${
                    txn.type === 'credit' ? 'bg-[#8BAE66]/10 text-[#8BAE66]' : 'bg-red-400/10 text-red-400'
                  }`}>
                    {txn.type === 'credit' ? <ArrowDownRight size={18} /> : <ArrowUpRight size={18} />}
                  </div>
                  <div>
                    <h4 className="font-bold text-[#EBD5AB] text-sm group-hover:text-[#8BAE66] transition-colors">{txn.partner}</h4>
                    <p className="text-xs text-[#EBD5AB]/50 font-medium mt-0.5">{txn.date}</p>
                  </div>
                </div>
                <div className="text-right">
                  <p className={`font-black ${txn.type === 'credit' ? 'text-[#8BAE66]' : 'text-[#EBD5AB]'}`}>
                    {txn.type === 'credit' ? '+' : '-'}₱{txn.amount.toFixed(2)}
                  </p>
                  <p className="text-[10px] text-[#628141] font-bold uppercase tracking-wider mt-0.5">{txn.status}</p>
                </div>
              </motion.div>
            ))}
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="flex flex-col min-h-full p-4 space-y-6 pt-8 pb-24 bg-[#1B211A]">
      <header className="flex justify-between items-center mb-2">
        <h1 className="text-2xl font-bold tracking-tight text-[#EBD5AB]">Wallet</h1>
        <button className="p-2 bg-[#2A3329] rounded-full text-[#8BAE66] hover:bg-[#628141] hover:text-[#1B211A] transition-colors shadow-md border border-[#628141]/30">
          <History size={20} />
        </button>
      </header>

      <motion.div
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        className="bg-gradient-to-br from-[#628141] to-[#2A3329] rounded-3xl p-6 shadow-xl relative overflow-hidden text-[#1B211A] border border-[#8BAE66]/40"
      >
        <div className="absolute -right-10 -top-10 opacity-10">
          <WalletIcon size={180} />
        </div>
        
        <div className="flex justify-between items-start mb-6">
          <div className="flex items-center space-x-2 bg-[#1B211A]/20 px-3 py-1.5 rounded-full backdrop-blur-sm border border-[#1B211A]/10 shadow-inner">
            <PiggyBank size={14} className="text-[#EBD5AB]" />
            <span className="text-[#EBD5AB] text-xs font-bold uppercase tracking-wider">Available Balance</span>
          </div>
        </div>
        
        <div className="flex items-baseline space-x-2">
          <span className="text-[#1B211A] text-2xl font-bold opacity-70">₱</span>
          <span className="text-5xl font-black text-[#1B211A] tracking-tighter drop-shadow-sm">42,500</span>
          <span className="text-[#1B211A] font-bold opacity-70">.00</span>
        </div>
        
        <div className="mt-8 flex space-x-3 relative z-10">
          <button className="flex-1 bg-[#1B211A] text-[#8BAE66] py-3 rounded-2xl font-bold flex items-center justify-center hover:bg-[#2A3329] transition-colors shadow-md border border-[#1B211A]/20">
            <ArrowUpRight size={18} className="mr-2" /> Withdraw
          </button>
          <button className="flex-1 bg-[#8BAE66]/30 text-[#1B211A] py-3 rounded-2xl font-bold flex items-center justify-center hover:bg-[#8BAE66]/50 transition-colors backdrop-blur-sm shadow-sm border border-[#1B211A]/10">
            <Download size={18} className="mr-2" /> Receive
          </button>
        </div>
      </motion.div>

      <div className="grid grid-cols-2 gap-4">
        <div className="bg-[#2A3329] p-4 rounded-2xl border border-[#628141]/30 flex items-center space-x-3 shadow-md group hover:border-[#8BAE66]/50 transition-colors">
          <div className="w-10 h-10 rounded-full bg-[#8BAE66]/10 flex items-center justify-center text-[#8BAE66] shadow-inner group-hover:bg-[#8BAE66]/20 transition-colors">
            <ArrowDownRight size={20} />
          </div>
          <div>
            <p className="text-xs text-[#EBD5AB]/60 font-medium">This Month</p>
            <p className="text-lg font-bold text-[#EBD5AB]">+₱12,400</p>
          </div>
        </div>
        <div className="bg-[#2A3329] p-4 rounded-2xl border border-[#628141]/30 flex items-center space-x-3 shadow-md group hover:border-[#8BAE66]/50 transition-colors">
          <div className="w-10 h-10 rounded-full bg-red-400/10 flex items-center justify-center text-red-400 shadow-inner group-hover:bg-red-400/20 transition-colors">
            <ArrowUpRight size={20} />
          </div>
          <div>
            <p className="text-xs text-[#EBD5AB]/60 font-medium">Withdrawn</p>
            <p className="text-lg font-bold text-[#EBD5AB]">-₱4,500</p>
          </div>
        </div>
      </div>

      <div className="mt-6">
        <div className="flex justify-between items-center mb-4">
          <h3 className="text-lg font-bold text-[#EBD5AB]">Recent Transactions</h3>
          <button className="text-sm text-[#8BAE66] font-semibold hover:underline">See All</button>
        </div>

        <div className="flex space-x-2 mb-4 overflow-x-auto pb-1 scrollbar-hide">
          {["All", "Credits", "Withdrawals"].map((tab) => (
            <button
              key={tab}
              onClick={() => setActiveTab(tab.toLowerCase())}
              className={`px-4 py-1.5 rounded-full text-xs font-bold transition-all shadow-sm ${
                activeTab === tab.toLowerCase() || (activeTab === 'all' && tab === 'All')
                  ? "bg-[#628141] text-[#1B211A] border border-[#628141]"
                  : "bg-[#2A3329] text-[#EBD5AB]/60 border border-[#628141]/30 hover:border-[#8BAE66]/50 hover:text-[#EBD5AB]"
              }`}
            >
              {tab}
            </button>
          ))}
        </div>

        <div className="space-y-3">
          {transactions.map((txn, index) => (
            <motion.div
              key={txn.id}
              initial={{ opacity: 0, y: 10 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: 0.1 + index * 0.1 }}
              className="bg-[#2A3329]/50 p-4 rounded-2xl border border-[#628141]/20 flex items-center justify-between shadow-sm hover:bg-[#2A3329] transition-colors group cursor-pointer"
            >
              <div className="flex items-center space-x-3">
                <div className={`w-10 h-10 rounded-full flex items-center justify-center shadow-inner ${
                  txn.type === 'credit' ? 'bg-[#8BAE66]/10 text-[#8BAE66]' : 'bg-red-400/10 text-red-400'
                }`}>
                  {txn.type === 'credit' ? <ArrowDownRight size={18} /> : <ArrowUpRight size={18} />}
                </div>
                <div>
                  <h4 className="font-bold text-[#EBD5AB] text-sm group-hover:text-[#8BAE66] transition-colors">{txn.partner}</h4>
                  <p className="text-xs text-[#EBD5AB]/50 font-medium mt-0.5">{txn.date}</p>
                </div>
              </div>
              <div className="text-right">
                <p className={`font-black ${txn.type === 'credit' ? 'text-[#8BAE66]' : 'text-[#EBD5AB]'}`}>
                  {txn.type === 'credit' ? '+' : '-'}₱{txn.amount.toFixed(2)}
                </p>
                <p className="text-[10px] text-[#628141] font-bold uppercase tracking-wider mt-0.5">{txn.status}</p>
              </div>
            </motion.div>
          ))}
        </div>
      </div>
    </div>
  );
}
