import { useState } from 'react';
import LoginPage from './components/LoginPage';
import PlayersPage from './components/PlayersPage';
import TournamentsPage from './components/TournamentsPage';
import DashboardPage from './components/DashboardPage';
import ReportsPage from './components/ReportsPage';

export interface Player {
  id: string;
  name: string;
  position: string;
  age: number;
  team: string;
}

export interface Tournament {
  id: string;
  name: string;
  startDate: string;
  endDate: string;
  status: 'upcoming' | 'ongoing' | 'completed';
  participants: number;
  winner?: string;
}
export default function App() {
  const [isAuthenticated, setIsAuthenticated] = useState(false);
  const [currentPage, setCurrentPage] = useState<'dashboard' | 'players' | 'tournaments' | 'reports'>('dashboard');
  
  const [players, setPlayers] = useState<Player[]>([
    { id: '1', name: 'John Smith', position: 'Forward', age: 24, team: 'Team A' },
    { id: '2', name: 'Sarah Johnson', position: 'Midfielder', age: 22, team: 'Team A' },
    { id: '3', name: 'Mike Davis', position: 'Defender', age: 26, team: 'Team B' },
    { id: '4', name: 'Emily Brown', position: 'Goalkeeper', age: 25, team: 'Team B' },
  ]);

  const [tournaments, setTournaments] = useState<Tournament[]>([
    { id: '1', name: 'Summer Championship', startDate: '2025-06-15', endDate: '2025-06-30', status: 'upcoming', participants: 8 },
    { id: '2', name: 'Spring Cup', startDate: '2025-03-10', endDate: '2025-03-25', status: 'completed', participants: 12, winner: 'Team A' },
    { id: '3', name: 'Winter League', startDate: '2025-12-01', endDate: '2025-12-20', status: 'ongoing', participants: 10 },
  ]);

  const handleLogin = (email: string, password: string) => {
    // Mock authentication - accept any email/password for demo
    if (email && password) {
      setIsAuthenticated(true);
      return true;
    }
    return false;
  };

  const handleLogout = () => {
    setIsAuthenticated(false);
    setCurrentPage('dashboard');
  };

  const addPlayer = (player: Omit<Player, 'id'>) => {
    const newPlayer = {
      ...player,
      id: (players.length + 1).toString(),
    };
    setPlayers([...players, newPlayer]);
  };

  const updatePlayer = (id: string, updatedPlayer: Omit<Player, 'id'>) => {
    setPlayers(players.map(p => p.id === id ? { ...updatedPlayer, id } : p));
  };

  const deletePlayer = (id: string) => {
    setPlayers(players.filter(p => p.id !== id));
  };

  const addTournament = (tournament: Omit<Tournament, 'id'>) => {
    const newTournament = {
      ...tournament,
      id: (tournaments.length + 1).toString(),
    };
    setTournaments([...tournaments, newTournament]);
  };

  const updateTournament = (id: string, updatedTournament: Partial<Tournament>) => {
    setTournaments(tournaments.map(t => t.id === id ? { ...t, ...updatedTournament } : t));
  };

  const deleteTournament = (id: string) => {
    setTournaments(tournaments.filter(t => t.id !== id));
  };

  if (!isAuthenticated) {
    return <LoginPage onLogin={handleLogin} />;
  }

  return (
    <div className="flex h-screen bg-gray-50">
      {currentPage === 'dashboard' && (
        <DashboardPage
          currentPage={currentPage}
          onNavigate={setCurrentPage}
          onLogout={handleLogout}
          players={players}
          tournaments={tournaments}
        />
      )}
      {currentPage === 'players' && (
        <PlayersPage
          currentPage={currentPage}
          onNavigate={setCurrentPage}
          onLogout={handleLogout}
          players={players}
          onAddPlayer={addPlayer}
          onUpdatePlayer={updatePlayer}
          onDeletePlayer={deletePlayer}
        />
      )}
      {currentPage === 'tournaments' && (
        <TournamentsPage
          currentPage={currentPage}
          onNavigate={setCurrentPage}
          onLogout={handleLogout}
          tournaments={tournaments}
          players={players}
          onAddTournament={addTournament}
          onUpdateTournament={updateTournament}
          onDeleteTournament={deleteTournament}
        />
      )}
      {currentPage === 'reports' && (
        <ReportsPage
          currentPage={currentPage}
          onNavigate={setCurrentPage}
          onLogout={handleLogout}
          players={players}
          tournaments={tournaments}
        />
      )}
    </div>
  );
}
